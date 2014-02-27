class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #
  # Letting declarative authorization know who the current user is.
  #
  before_filter { |c| Authorization.current_user = c.current_user }


  def permission_denied
    redirect_to root_url
  end
end
