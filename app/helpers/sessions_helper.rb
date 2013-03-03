module SessionsHelper

  #
  # Signs in a user by saving there session token in a cookie.
  #
  def sign_in(user)
    cookies.permanent[:session_token] = user.session_token
    self.current_user = user
  end

  #
  # Sign out a user by setting the current user to nil
  # and delte the session token cookie
  #
  def sign_out
    self.current_user = nil
    cookies.delete(:session_token)
  end

  #
  # current user mutator method.
  #
  def current_user=(user)
    @current_user = user
  end

  #
  # current_user accessor method
  # It returns the current user if the user is present otherwise it
  # retrieves the user by there session token.
  #
  def current_user
    @current_user ||= User.find_by_session_token(cookies[:session_token])
  end


  def current_user?(user)
    user == current_user
  end

  #
  # Returns true of false if the user id signed in or not.
  #
  def signed_in?
    !current_user.nil?
  end
end
