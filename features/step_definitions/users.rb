Then(/^I should see a list of users$/) do
  assert page.has_content?(I18n.t('users.accounts'))
  page.assert_selector(".main-input-area table.sortable tbody tr", :count => 6)
end

When(/^I attempt to add a new user with valid inputs$/) do
  $inputs_to_test = ProfileValidator::get_valid_users
end

When(/^I attempt to add a new user with invalid inputs$/) do
  $inputs_to_test = ProfileValidator::get_invalid_users
end

Then(/^I should succeed in creating that user$/) do
  $inputs_to_test.each do |inputs|
    puts inputs
    visit "/users/new"
    enter_inputs inputs
    page.find("form.new_user input[name='commit']").click
    assert_redirected_to_user_profile
    assert page.has_content?(I18n.t('users.account-created'))
  end
end

Then(/^I should see an error$/) do
  $inputs_to_test.each do |inputs|
    puts inputs
    visit "/users/new"
    enter_inputs inputs
    page.find("form.new_user input[name='commit']").click
    assert_profile_error inputs
  end
end

When(/^I attempt to delete an existing user$/) do
  visit "/users"
  assert page.has_content?($user_to_delete[:email])
  delete_link = page.find("table tbody a[data-method='delete'][href='/users/#{$user_to_delete[:id]}?page=1']")
  delete_link.click
end

Then(/^I should succeed in deleting that user$/) do
  assert !page.has_content?($user_to_delete[:email])
end