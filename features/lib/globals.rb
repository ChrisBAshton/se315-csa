# Global variables referenced throughout the RSpec methods.
# As a general rule, global variables are a bad idea. By tracking them here,
# I can make an active effort to remove them in future versions.

$userID = false         # overriden when calling the login_user/login_admin methods
$map    = UrlMapper.new # maps page titles to urls. Also takes into account current user id