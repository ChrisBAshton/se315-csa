def assert_can_visit_all (pages)
  pages.each do |page_title|
    url = $map.get_url_from(page_title, track_pages_visited: true)
    visit url
    assert successfully_reached_page, "Should have successfully reached " + url
  end
end