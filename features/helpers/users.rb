$inputs_to_test # global
$user_to_delete = {
  email: "cwl1@aber.ac.uk",
  id:    "2"
}

def enter_inputs(inputs)
  fill_in('First name', :with => inputs[:firstname])
  fill_in('Surname',    :with => inputs[:surname])
  fill_in('Phone',      :with => inputs[:phone])
  fill_in('Grad. year', :with => inputs[:grad_year])
  fill_in('Email',      :with => inputs[:email])
  fill_in('Login',      :with => inputs[:login])
  fill_in('Password',   :with => inputs[:password])

  # special cases. "Confirm password" label doesn't link to the corresponding input field
  page.find("#user_user_detail_attributes_password_confirmation").set(inputs[:password_conf])

  # checkbox doesn't have a value as such
  if inputs[:jobs]
    check 'Jobs'
  else
    uncheck 'Jobs'
  end

  if inputs[:picture]
    attach_file('image_file', File.expand_path(inputs[:picture]))
  end
end

def assert_redirected_to_user_profile
  uri = current_url.to_s.scan(/([^\/]+)$/)[0][0] # get end of url
  user_id = uri.split("?")[0]
  assert is_numeric? user_id
end

# Credit: Jacob Relkin
# http://stackoverflow.com/a/4589982
def is_numeric?(obj) 
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
end