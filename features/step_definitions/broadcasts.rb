require 'json'

Then(/^I should see a list of broadcasts$/) do
  assert page.has_content?(I18n.t('broadcasts.list'))
  page.assert_selector("table.sortable tbody tr", :count => 8)
end

Then(/^I should see the broadcast history$/) do
  assert page.has_content?(I18n.t('broadcasts.details'))
  assert page.has_content?("Hello, World... yet again.")
end

When(/^I attempt to delete the history of a specific broadcast$/) do
  # item number 3 from seeds.rb
  selector_of_broadcast_to_delete = "a[data-method='delete'][href='/broadcasts/3?page=1']"
  assert page.has_selector?(selector_of_broadcast_to_delete)
  page.find(selector_of_broadcast_to_delete).click
end

Then(/^I should be successful in deleting it$/) do
  assert !page.has_selector?("a[data-method='delete'][href='/broadcasts/3?page=1']")
end

When(/^I attempt to send (a|a long) broadcast to (.+)$/) do |length_of_message, feeds|
  long_message = (length_of_message == "a long")
  write_message(long_message)
  check_boxes_corresponding_to feeds
  send_to_mailing_list 'jobs'
  click_button I18n.t('broadcasts.title')
end

Then(/^the broadcast should be sent successfully$/) do
  message = page.find(".flash_message")
  assert message.has_content?(I18n.t('broadcasts.saved-message'))

  if $twitter_broadcast
    assert_latest_tweet? $broadcast_message
  end
end

def assert_latest_tweet?(expected_tweet)
  retrieved_tweet = false
  begin
    response = TWITTER_ACCESS_TOKEN.get('/statuses/user_timeline.json?screen_name=chris_loftus_te&count=1')
    case response
      when Net::HTTPSuccess
        json = JSON.parse(response.body)
        retrieved_tweet = json[0]["text"]
      else # Something went wrong
        result = [feed: 'twitter', code: response.code, message: response.message]
    end
  rescue => e
    result = [feed: 'twitter', code: 500, message: e.message]
  end

  if retrieved_tweet
    assert retrieved_tweet == $broadcast_message
  else
    raise CouldNotGetTweet, 'Could not get the latest Tweet so could not perform assertion. Details: ' + result.to_s
  end
end

Then(/^the broadcast should not send at all$/) do
  message = page.find(".flash_error .flash_message")
  assert message.has_content?(I18n.t('broadcasts.no-feeds-selected'))
end

Then(/^the broadcast should not send to all feeds$/) do
  message = page.find(".flash_error .flash_message")
  assert message.has_content?(I18n.t('broadcasts.saved-but-message'))
end

def check_boxes_corresponding_to (feeds)
  boxes = calculate_which_boxes_to_check feeds
  check_the boxes
end

def send_to_mailing_list (list)
  if list == 'jobs'
    selector = 'feeds_alumni_email_cs-alumni-jobs' # Jobs
  else
    selector = 'feeds_alumni_email_cs-alumni'      # News
  end
  page.choose(selector)
end

def check_the (boxes)
  html_ids = {
    email:    'feeds_email',
    facebook: 'feeds_facebook',
    rss:      'feeds_RSS',
    atom:     'feeds_atom',
    twitter:  'feeds_twitter'
  }

  boxes.each do |key, check_it|
    if (check_it)
      check html_ids[key]
    else
      uncheck html_ids[key]
    end
  end
end

def calculate_which_boxes_to_check (feeds)
  if feeds == "all feeds"
    bool = true
  else
    bool = false
  end

  checkboxes = {
    email:    bool,
    facebook: bool,
    rss:      bool,
    atom:     bool,
    twitter:  bool
  }
  
  if feeds == "the Twitter feed"
    checkboxes[:twitter] = true
    $twitter_broadcast = true
  elsif feeds == "the email feed"
    checkboxes[:email] = true
    $twitter_broadcast = false
  end

  return checkboxes
end

def write_message(long)
  if (long)
    message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit odio. Cras pretium facilisis metus ac imperdiet. Nullam gravida ornare eros ut pulvinar. Phasellus mollis dolor at eros dapibus, vitae posuere mauris rhoncus. Nunc vel orci nisl. Ut quis velit porttitor, molestie mi in, iaculis lacus. Nunc dictum urna sit amet dignissim pellentesque. Nulla pellentesque arcu posuere blandit porttitor. Fusce a laoreet ligula. Quisque a enim ante. Pellentesque porttitor risus vitae neque pretium, tempor maximus leo bibendum. Pellentesque lacinia metus id iaculis iaculis. Curabitur id nibh leo. Duis ipsum lectus, vestibulum a lectus quis, placerat porta lorem. Integer vulputate, odio eu elementum mollis, tortor nibh pulvinar est, eu feugiat velit arcu ut nisl."
  else
    message = "Travis Tells a Terrific Tweet"
  end

  timestamp = Time.now.getutc.to_s

  message = message + ". (" + timestamp + ")"

  $broadcast_message = message

  page.find('#broadcast_content').set(message)
end