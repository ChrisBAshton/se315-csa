When(/^I attempt to visit someone else's user profile$/) do
  visit "/users/30"
end

Then(/^I should be redirected to the (.+)$/) do |different_page|
  uri = URI.parse(current_url)
  assert_equal uri.path, get_url_from_page_description(different_page)
end

Then(/^I should not see the profile$/) do
  page.assert_selector(".flash_error", :count => 1)
  assert page.has_content?("This is not your account, access denied")
end

When(/^I attempt to visit my own profile$/) do
  visit "/users/" + $userID.to_s
end

Then(/^I should successfully see the profile$/) do
  page.assert_selector(".flash_error", :count => 0)
  page.assert_selector(".content-image, .content-detail", :count => 2)
end

When(/^I attempt to visit the profile of a non\-existent user$/) do
  visit "/users/-3"
end