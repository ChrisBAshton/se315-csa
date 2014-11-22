def login_user
  login_with_credentials 'cwl20', 'secret'
end

def login_admin
  login_with_credentials 'admin', 'taliesin'
end

def login_with_credentials (username, password)
  visit "/session/new"
  within("form[action='/session']") do
    fill_in 'login', :with => username
    fill_in 'password', :with => password
    click_button 'Login'
  end
end