class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private
    def redirect_to_root
      redirect_to root_path
    end

end
