include ApplicationHelper

def login(user)
  visit new_user_session_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def admin_login(admin)
  remember_token = Admin.new_remember_token
  cookies[:remember_token] = remember_token
  admin.update_attribute(:remember_token, Admin.encrypt(remember_token))
end