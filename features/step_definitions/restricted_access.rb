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