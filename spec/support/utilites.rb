#include ApplicationHelper
module Utilites
  def login(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  def admin_login(admin)
    visit admin_root_path
    fill_in "Login",    with: admin.login
    fill_in "Password", with: admin.password
    click_button "sign in"
  end

  def admin_user_form(hash)
    if hash[:valid]
      fill_in 'Username', with: 'new_user_username'
      fill_in 'Email', with: 'new_user@email.ru'
      fill_in 'Password', with: 'new_user_password'
    else
      fill_in 'Username', with: 'new_user_username'
      fill_in 'Email', with: 'new_useremail.ru'
      fill_in 'Password', with: 'pass'
    end
  end
end