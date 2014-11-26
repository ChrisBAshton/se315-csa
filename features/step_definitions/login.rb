When(/^I try to log in with invalid credentials$/) do
  invalids = [
    ['', ''],                   # blank inputs
    ['cwl20', ''],              # valid username, blank password
    ['cwl20', 'taliesin'],      # valid username, using the password of a different user
    ['"; DROP TABLE users', ''] # invalid (and potentially dangerous) username
  ]
  invalids.each_with_index do |credentials, index|
    login_with_credentials credentials[0], credentials[1]
    store_page_body page.body, index
  end
end

Then(/^I should NOT succeed in logging in$/) do
  expect_in_each_body "Couldn't log you in as"
end

When(/^I try to log in with valid credentials$/) do
  login_user
  store_page_body page.body
end

Then(/^I should succeed in logging in$/) do
  expect_in_each_body "Logged in successfully"
end

When(/^I try to log out$/) do
  click_button 'Logout'
end

Then(/^I should succeed in logging out$/) do
  assert page.has_selector?("form[action='/session/new']")
end