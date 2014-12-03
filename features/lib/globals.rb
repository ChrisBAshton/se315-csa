# Global variables and methods referenced throughout the RSpec methods.
# As a general rule, global variables are a bad idea. By tracking them here,
# I can make an active effort to remove them in future versions.

##########################################
# global variables
##########################################

$userID = false         # overriden when calling the login_user/login_admin methods
$map    = UrlMapper.new # maps page titles to urls. Also takes into account current user id

##########################################
# global methods
##########################################

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
    click_button I18n.t('sessions.login')
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

def assert_profile_error (inputs = false)
  flash_message = page.all('.flash_error .flash_message')
  if (flash_message.count > 0)
    image_error = flash_message[0].has_content?(I18n.t('users.invalid-image'))
  end
  other_error = page.has_selector?("#error_explanation")
  assert (image_error || other_error), "Should not be a valid user: " + (inputs ? inputs.to_s : '')
end