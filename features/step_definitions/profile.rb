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