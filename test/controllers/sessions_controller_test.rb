require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  test "should show login screen" do
    get :new
    assert_response :success
  end

  test "should login" do 
    post :create, params: {login: 'admin', password: 'taliesin'}
    assert_redirected_to new_session_url
  end

  test "should logout" do 
    delete :destroy
    assert_redirected_to home_url
  end

end