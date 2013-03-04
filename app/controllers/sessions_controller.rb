class SessionsController < ApplicationController
  # GET /sessions
  def new
  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:session][:email])
    if user and user.authenticate(params[:session][:password])
      # Sign in the user.
      sign_in user
      redirect_back_or user
    else
      render 'new'
    end
  end

  # DELETE /sessions
  def destroy
    sign_out
    redirect_to root_path
  end
end
