class PasswordResetsController < ApplicationController
  # GET /password_resets/new
  # GET /password_resets/new.json
  def new
  end

  # GET /password_reset/as393JDKDSK3/edit
  # GET /password_reset/as393JDKDSK3/edit.json
  def edit
    # usingthe bang at the end of the method will cause
    # a 404 if
   @user = User.find_by_password_reset_token(params[:id])
  end

  # POST /password_resets
  # POST /password_resets.json
  def create
    user = User.find_by_email(params[:password_reset][:email])
    user.send_password_reset_email if user
    redirect_to root_path
  end

  # PUT /password_reset/as393JDKDSK3
  # PUT /password_reset/as393JDKDSK3.json
  def update
   @user = User.find_by_password_reset_token(params[:id])

   respond_to do |format|
     if @user and @user.update_attributes(params[:user])
       format.html { redirect_to root_path, notice: "Password was successfully reset." }
       format.json { head :no_content }
     else
       format.html { render action: "edit", notice: "Password reset was not successful." }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
   end
  end
end
