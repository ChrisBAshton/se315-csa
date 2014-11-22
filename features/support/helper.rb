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
  case who
  when "my own"
    $userID
  when "another user's"
    $userID == 30 ? 31 : 30
  when "a non-existent user's"
    -4
  else
    raise "Invalid option! Not sure which user ID to provide."
  end
end

def make_url (description, user_id = false)
  if (user_id)
    return make_url_using_user_id(description, user_id)
  else
    return make_url_without_user_id(description)
  end
end

def make_url_without_user_id (description)
  url = ""
  case description
  when "login screen"
    url = "/session/new"
  when "page of users"
    url = "/users"
  end
  return url
end

def make_url_using_user_id (description, user_id)
  url = ""
  case description
  when "'Profile' page"
    url = "/users/#{user_id}"
  when "'Edit Profile' page"
    url = "/users/#{user_id}/edit"
  end
  return url
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