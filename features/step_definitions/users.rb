$inputs_to_test # global
$user_to_delete = {
  email: "cwl1@aber.ac.uk",
  id:    "2"
}

Then(/^I should see a list of users$/) do
  assert page.has_content?("User accounts")
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
    assert page.has_content?("Account was successfully created")
  end
end

Then(/^I should see an error$/) do
  $inputs_to_test.each do |inputs|
    puts inputs
    visit "/users/new"
    enter_inputs inputs
    page.find("form.new_user input[name='commit']").click
    assert page.has_selector?("#error_explanation"), "Should not be a valid user: " + inputs.to_s
  end
end

def enter_inputs(inputs)
  page.find("#user_firstname").set(inputs[:firstname])
  page.find("#user_surname").set(inputs[:surname])
  page.find("#user_grad_year").set(inputs[:grad_year])
  page.find("#user_phone").set(inputs[:phone])
  if inputs[:jobs]
    page.find("#user_jobs").click
  end
  page.find("#user_email").set(inputs[:email])
  page.find("#user_user_detail_attributes_login").set(inputs[:login])
  page.find("#user_user_detail_attributes_password").set(inputs[:password])
  page.find("#user_user_detail_attributes_password_confirmation").set(inputs[:password_conf])
end

def assert_redirected_to_user_profile
  uri = current_url.to_s.scan(/([^\/]+)$/)[0][0] # get end of url
  user_id = uri.split("?")[0]
  assert is_numeric? user_id
end

# Credit: Jacob Relkin
# http://stackoverflow.com/a/4589982
def is_numeric?(obj) 
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
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