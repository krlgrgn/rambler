class SessionsController < ApplicationController
  # GET /sessions
  def new
  end

  # POST /sessions
  def create
    @user = User.find_by_email(params[:session][:email])
    respond_to do |format|
      if @user and @user.authenticate(params[:session][:password])
        # Sign in the user.
        sign_in(@user)
        format.html { redirect_back_or @user }
        format.json { render json: @user }
      else
        format.html { render action: "new" }
      end
    end
  end

  # GET /auth/:provider/callback
  def fb_create
    @user = User.from_omniauth(env["omniauth.auth"])
    respond_to do |format|
      if @user
        # Sign in the user.
        sign_in @user
        format.html { redirect_back_or @user }
        format.json { render json: @user }
      else
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /sessions
  def destroy
    sign_out
    redirect_to root_path
  end
end
