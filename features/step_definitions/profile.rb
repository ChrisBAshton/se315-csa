When(/^I attempt to visit (.+)$/) do |page_description|
  $map.clean_slate
  url = $map.get_url_from(page_description)
  visit url
end

Then(/^I should be redirected to the (.+)$/) do |different_page|
  uri = URI.parse(current_url)
  assert_equal uri.path, $map.get_url_from(different_page)
end

Then(/^I should be blocked from seeing the content$/) do
    assert failed_to_reach_page, "Should not have reached page"
end

Then(/^I should successfully see the 'Profile' page$/) do
  page.assert_selector(".flash_error", :count => 0)
  page.assert_selector(".content-image, .content-detail", :count => 2)
end

Then(/^I should successfully see the 'Edit Profile' page$/) do
  page.assert_selector(".edit_user", :count => 1)
end