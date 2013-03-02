module Utilities
  def sign_in(user)
    visit signin_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "12345678"
    click_button "Sign in"

    # Add the cookie as well.
    cookies[:remember_token] = user.remember_token
  end
end
