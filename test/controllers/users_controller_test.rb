require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    # salt:               21613652800.8890977334258171
    # encrypted password: ced6c1da3e5436a7816d428910172927e0ac0fbaeb0b7454fb0a0372dceb3502
    @user.user_detail = UserDetail.authenticate('admin', 'taliesin')
    puts @user.user_detail  
    session[:user_id] = @user.user_detail
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: @user.email + 's',
                            firstname: @user.firstname,
                            grad_year: @user.grad_year,
                            jobs: @user.jobs,
                            phone: @user.phone,
                            surname: @user.surname }
    end

    assert_redirected_to "#{user_path(assigns(:user))}?page=1"
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, grad_year: @user.grad_year, jobs: @user.jobs, phone: @user.phone, surname: @user.surname }
    assert_redirected_to "#{user_path(assigns(:user))}?page=1"
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to "#{users_path}?page=1"
  end
end
