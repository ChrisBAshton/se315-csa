When(/^I attempt to visit (another user's|my own|a non\-existent user's) (.+)$/) do |who, page_description|
  url = make_url(page_description, get_user_id(who))
  visit url
end

Then(/^I should be redirected to the (.+)$/) do |different_page|
  uri = URI.parse(current_url)
  assert_equal uri.path, make_url(different_page)
end

Then(/^I should be blocked from seeing the content$/) do
  page.assert_selector(".flash_error", :count => 1)
  assert page.has_content?("This is not your account, access denied")
end

Then(/^I should successfully see the 'Profile' page$/) do
  page.assert_selector(".flash_error", :count => 0)
  page.assert_selector(".content-image, .content-detail", :count => 2)
end

Then(/^I should successfully see the 'Edit Profile' page$/) do
  page.assert_selector(".edit_user", :count => 1)
end