When(/^I attempt to send (a|a long|an empty) broadcast to (.+)$/) do |length_of_message, feeds|
  write_message(length_of_message)
  check_boxes_corresponding_to feeds
  send_to_mailing_list 'jobs'
  click_button I18n.t('broadcasts.title')
end

Then(/^the broadcast should be sent successfully$/) do
  message = page.find(".flash_message")
  assert message.has_content?(I18n.t('broadcasts.saved-message')), "Should have this message: " + I18n.t('broadcasts.saved-message') + ". ACTUALLY had: " + message.native.inner_html

  if $twitter_broadcast
    assert_latest_tweet? $broadcast_message
  end
end

Then(/^the broadcast should not send at all$/) do
  blank = page.has_selector?("#error_explanation")
  no_feeds = page.has_selector?("flash_error .flash_message")
  if blank
    assert page.has_content?("Content can't be blank") # not internationalised, error message built into Rails
  else
    message = page.find(".flash_error .flash_message")
    assert message.has_content?(I18n.t('broadcasts.no-feeds-selected'))
  end
end

Then(/^the broadcast should not send to all feeds$/) do
  message = page.find(".flash_error .flash_message")
  assert message.has_content?(I18n.t('broadcasts.saved-but-message'))
end