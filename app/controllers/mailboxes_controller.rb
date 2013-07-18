class MailboxesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user

  # GET /users/1/mailbox
  # GET /users/1/mailbox.json
  def show
    @mailbox = @user.mailbox

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mailbox }
    end
  end

  private
    def signed_in_user
      if !signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      #user_id is the user ID associated with the mailbox.
      @user = User.find(params[:user_id])
      redirect_to root_path if !current_user?(@user)
    end
end
