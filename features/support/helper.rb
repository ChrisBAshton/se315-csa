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

def get_url_from_page_description (description)
  case description
  when "login screen"
    expected_url = "/session/new"
  when "page of users"
    expected_url = "/users"
  else
    expected_url = ""
  end
  return expected_url
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