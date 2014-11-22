# Global variables referenced throughout the RSpec methods

$userID = false         # overriden when calling the login_user/login_admin methods
$map    = UrlMapper.new # maps page titles to urls. Also takes into account current user id