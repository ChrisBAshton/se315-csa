def make_admin_session (user)
    UserDetail.create!(login: 'admin', password: 'taliesin', user: user)
    user.user_detail = UserDetail.authenticate('admin', 'taliesin')
    session[:user_id] = user.user_detail
end