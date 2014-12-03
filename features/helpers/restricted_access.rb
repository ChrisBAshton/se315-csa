def assert_can_visit_all (pages)
  pages.each do |page_title|
    url = $map.get_url_from(page_title, track_pages_visited: true)
    visit url
    assert successfully_reached_page, "Should have successfully reached " + url
  end
end

def successfully_reached_page
  no_error_message = !page.has_selector?(".flash_error")
  no_login_prompt  = !page.has_content?(I18n.t('sessions.login-please'))
  return no_error_message && no_login_prompt
end

def failed_to_reach_page
  return !successfully_reached_page
end