$inputs_to_test # global
$user_to_delete = {
  email: "cwl1@aber.ac.uk",
  id:    "2"
}

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

Given(/^I have JavaScript (enabled|disabled)$/) do |javascript|
  if javascript == "enabled"
    $js = true
    $results_container_selector = ".ui-autocomplete .ui-menu-item"
  else
    $js = false
    $results_container_selector = ".main-input-area table.sortable tr"
  end
end

And(/^I search for users$/) do
  page.find('#q').set('cwl31')
  $search_box_selector = '#q'
end

Then(/^I should see the results$/) do
  searches = [
    {
      term:             "cwl1",
      boxes:            ['firstname', 'surname', 'grad_year', 'phone', 'email'],
      expected_results: ['cwl1', 'cwl10', 'cwl11', 'cwl12', 'cwl13', 'cwl14', 'cwl15', 'cwl16', 'cwl17', 'cwl18', 'cwl19']
    },
    {
      term:             "cwl12",
      boxes:            ['firstname', 'surname', 'grad_year', 'phone', 'email'],
      expected_results: ['cwl12']
    },
    {
      term:             "Loftus",
      boxes:            ['surname'],
      expected_results: ['cwl']
    }
  ]

  searches.each do |search|
    visit "/users"

    set_boxes search[:boxes]
    page.find($search_box_selector).set(search[:term])

    if !$js
      click_button I18n.t('users.search')
      search[:expected_results] = search[:expected_results].first(User::per_page)
    else
      page.execute_script("$('#{$search_box_selector}').keydown()")
      sleep 1 # allow time for script to run and AJAX to be called
    end

    results = page.all($results_container_selector)
    search[:expected_results].each do |result|
      if $js
        # JS ajax only returns surname and picture, so we can't do much checking. Just make sure count is the same
        assert results.count == search[:expected_results].count
      else
        # non JS returns all the information, so we can loop through the table rows and assert we have the search term somewhere in the content
        assert results_contain_result(results, result)
      end
    end
  end
end

def results_contain_result (results, result)
  results.each do |result_html|
    if result_html.has_content?(result)
      return true
    end
  end
  return false
end

def set_boxes(boxes)
  page.find('#firstname').set(boxes.include? 'firstname')
  page.find('#surname').set(boxes.include? 'surname')
  page.find('#grad_year').set(boxes.include? 'grad_year')
  page.find('#phone').set(boxes.include? 'phone')
  page.find('#email').set(boxes.include? 'email')
  if $js
    # odd bug - have to click all the checkboxes again is JS enabled. But we still have
    # to run the page.find() code above. For some reason, Poltergeist seems to need the
    # checkboxes clicking twice!
    page.execute_script("$('.user_search_checkbox').click()")
  end
end

def enter_inputs(inputs)
  fill_in('First name', :with => inputs[:firstname])
  fill_in('Surname',    :with => inputs[:surname])
  fill_in('Phone',      :with => inputs[:phone])
  fill_in('Grad. year', :with => inputs[:grad_year])
  fill_in('Email',      :with => inputs[:email])
  fill_in('Login',      :with => inputs[:login])
  fill_in('Password',   :with => inputs[:password])

  # special cases. "Confirm password" label doesn't link to the corresponding input field
  page.find("#user_user_detail_attributes_password_confirmation").set(inputs[:password_conf])

  # checkbox doesn't have a value as such
  if inputs[:jobs]
    check 'Jobs'
  else
    uncheck 'Jobs'
  end

  if inputs[:picture]
    attach_file('image_file', File.expand_path(inputs[:picture]))
  end
end

def assert_redirected_to_user_profile
  uri = current_url.to_s.scan(/([^\/]+)$/)[0][0] # get end of url
  user_id = uri.split("?")[0]
  assert is_numeric? user_id
end