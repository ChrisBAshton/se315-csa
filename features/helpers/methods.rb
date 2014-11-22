def login_user
  login_with_credentials 'cwl20', 'secret'
  $userID = 21
end

def login_admin
  login_with_credentials 'admin', 'taliesin'
  $userID = 41
end

def login_with_credentials (username, password)
  visit "/session/new"
  within("form[action='/session']") do
    fill_in 'login', :with => username
    fill_in 'password', :with => password
    click_button 'Login'
  end
end

def get_user_id (who)
  id = 0
  case who
  when "my own"
    id = $userID.nil? ? 7 : $userID
  when "another user's"
    id = $userID == 30 ? 31 : 30
  when "a non-existent user's"
    id = -4
  end
  return id
end

def successfully_reached_page
  no_error_message = !page.has_selector?(".flash_error")
  no_login_prompt  = !page.has_content?("Please log in")
  return no_error_message && no_login_prompt
end

def failed_to_reach_page
  return !successfully_reached_page
end

def store_page_body (body, index = 0)
  if (index == 0)
    $bodies = []
  end
  $bodies.push(body)
end

def expect_in_each_body (message)
  $bodies.each do |body|
    page = Capybara::Node::Simple.new(body)
    assert page.has_content?(message)
  end
end