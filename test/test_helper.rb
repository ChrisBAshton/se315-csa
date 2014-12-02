# MONITOR CODE COVERAGE
require 'simplecov'

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def make_admin_session (user)
    UserDetail.create!(login: 'admin', password: 'taliesin', user: user)
    user.user_detail = UserDetail.authenticate('admin', 'taliesin')
    session[:user_id] = user.user_detail
end