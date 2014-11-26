$field_to_test  # global
$inputs_to_test # global

When(/^I edit my profile with a(?:n)? (valid|invalid) (.+)$/) do |valid_or_invalid, field_description|
  
  validity = (valid_or_invalid == "valid")

  $inputs_to_test = ProfileValidator::get_field_values(
    field: field_description,
    valid: validity
  )

  $field_to_test = ProfileValidator::convert_field_to_symbol field_description
end

Then(/^the changes should (be|NOT be) saved$/) do |to_be_or_not_to_be| # that is the question
  should_save = (to_be_or_not_to_be == "be")
  field = $field_to_test
  $inputs_to_test.each do |value|
    puts value.to_s
    attempt_to_edit field, value, should_save
  end
end

def attempt_to_edit (field, value, should_save)
  visit_edit_profile
  update_field field, value
  submit_form
  validate(should_save)
end

def visit_edit_profile
  $map.clean_slate
  visit $map.get_url_from("Edit Profile (own)")
end

def update_field(field, value)
  html_elements = {
    firstname:  "#user_firstname",
    surname:    "#user_surname",
    email:      "#user_email",
    phone:      "#user_phone",
    grad_year:  "#user_grad_year",
    jobs:       "#user_jobs"
  }

  if (field == :picture)
    if value
      attach_file('image_file', File.expand_path(value))
    end
  else
    page.find(html_elements[field]).set(value)
  end
end

def submit_form
  page.find(".edit_user input[name='commit']").click
end

def validate (should_save)
  if (should_save)
    validate_save
  else
    assert_profile_error
  end
end

# if successful, will redirect to Profile page
def validate_save
  uri = URI.parse(current_url)
  assert_equal uri.path, $map.get_url_from("Profile (own)"), "Page didn't save..."
  assert page.find(".flash_message").has_content?(I18n.t('users.account-created'))
end