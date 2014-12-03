require 'json'

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
  
  $twitter_broadcast = false
  if feeds == "the Twitter feed"
    checkboxes[:twitter] = true
    $twitter_broadcast = true
  elsif feeds == "the email feed"
    checkboxes[:email] = true
  elsif feeds == "a valid feed"
    checkboxes[:email] = true # can change this for any arbitrary feed
  end

  return checkboxes
end

def write_message(length_of_message)
  if length_of_message == "a long"
    message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit odio. Cras pretium facilisis metus ac imperdiet. Nullam gravida ornare eros ut pulvinar. Phasellus mollis dolor at eros dapibus, vitae posuere mauris rhoncus. Nunc vel orci nisl. Ut quis velit porttitor, molestie mi in, iaculis lacus. Nunc dictum urna sit amet dignissim pellentesque. Nulla pellentesque arcu posuere blandit porttitor. Fusce a laoreet ligula. Quisque a enim ante. Pellentesque porttitor risus vitae neque pretium, tempor maximus leo bibendum. Pellentesque lacinia metus id iaculis iaculis. Curabitur id nibh leo. Duis ipsum lectus, vestibulum a lectus quis, placerat porta lorem. Integer vulputate, odio eu elementum mollis, tortor nibh pulvinar est, eu feugiat velit arcu ut nisl."
  else
    message = "Travis Tells a Terrific Tweet"
  end

  timestamp = Time.now.getutc.to_s

  message = message + ". (" + timestamp + ")"
  
  if length_of_message == "an empty"
    message = ""
  end
  
  $broadcast_message = message

  page.find('#broadcast_content').set(message)
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