When(/^I edit my profile with a(?:n)? (valid|invalid) (.+)$/) do |valid_or_invalid, field_description|
  ProfileValidator::prepare(
    valid_inputs:      valid_or_invalid,
    field_description: field_description
  )
  assert ProfileValidator::field_and_values_are_not_empty
end

Then(/^the changes should (be|NOT be) saved$/) do |to_be_or_not_to_be| # that is the question
  should_save = (to_be_or_not_to_be == "be")
  field = ProfileValidator::get_field
  values = ProfileValidator::get_values
  values.each do |value|
    attempt_to_edit field, value, should_save
  end
end

def attempt_to_edit (field, value, should_save)
  # visit the Edit Profile page
  $map.clean_slate
  visit $map.get_url_from("Edit Profile (own)")

  # update the field
  page.find(field).set(value)

  # submit the form
  page.find(".edit_user input[name='commit']").click

  validate(should_save)
end

def validate (should_save)
  if (should_save)
    validate_save
  else
    validate_did_not_save
  end
end

# if successful, will redirect to Profile page
def validate_save
  uri = URI.parse(current_url)
  assert_equal uri.path, $map.get_url_from("Profile (own)"), "Page didn't save..."
end

# if unsuccessful, page won't redirect, error message will be displayed
def validate_did_not_save
  assert page.has_selector?("#error_explanation"), "The form data was invalid, but the changes were saved!"
end