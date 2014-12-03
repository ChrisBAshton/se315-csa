Given(/^I have JavaScript (enabled|disabled)$/) do |javascript|
  if javascript == "enabled"
    $js = true
    $results_container_selector = ".ui-autocomplete .ui-menu-item"
  else
    $js = false
    $results_container_selector = ".main-input-area table.sortable tr"
  end
end

When(/^the following boxes are checked: (.+)$/) do |boxes|
  boxes = extract_elements boxes
  set_boxes boxes
end

When(/^I search for the following term: (.+)$/) do |search_term|
  page.find('#q').set(search_term)
end

Then(/^I should see the following results: (.+)$/) do |results|
  results = extract_elements results
  if !$js
    click_button I18n.t('users.search')
  else
    page.execute_script("$('#q').keydown()")
    sleep 1 # allow time for script to run and AJAX to be called
  end

  html_elements = page.all($results_container_selector)
  results.each do |result|
    if $js
      # JS ajax only returns surname and picture, so we can't do much checking. Just make sure count is the same
      assert html_elements.count == results.count
    else
      # non JS returns all the information, so we can loop through the table rows and assert we have the search term somewhere in the content
      assert results_contain_result(html_elements, result), "Could not find " + result
    end
  end
end