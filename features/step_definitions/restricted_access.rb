Then(/^I should be able to access: (.+)$/) do |pages|
  $map.clean_slate()
  pages.split(", ").each do |page_title|
    url = $map.get_url_from(page_title)
    visit url
    assert successfully_reached_page, "Should have successfully reached " + url
  end
end

And(/^I should not have access to any other pages$/) do
  $map.get_restricted_pages.each do |url_of_restricted_page|
    visit url_of_restricted_page
    assert failed_to_reach_page, "Should not have been able to access " + url_of_restricted_page
  end
end

Then(/^I should be able to access every page$/) do
  $map.clean_slate()
  $map.get_all_pages.each do |url|
    visit url
    assert successfully_reached_page, "Should have successfully reached " + url
  end
end

When(/^I attempt to visit (.+)$/) do |page_description|
  $map.clean_slate
  url = $map.get_url_from(page_description)
  visit url
end

Then(/^I should be redirected to (.+)$/) do |different_page|
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