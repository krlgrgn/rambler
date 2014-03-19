class UsersController < ApplicationController
  before_filter :user_params, :only => [:create, :update]

  #
  # This is a declarative authorization method that acts as
  # a before filter. It loads the single resource, a user in this case, and
  # checks the access on it.
  # It only operates on the CRUD operations: show, new, edit, create, udpdate.
  #
  filter_resource_access

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # Allow a user view another user's profile to send them a message.
    @message = Message.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.js { render json: @user, callback: params[:callback] }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    # @user is assigned in the before filter method forthis action.
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Since we require the user to be signed in when viewing his/her and other profiles
        # we need to sign the user.
        sign_in(@user) # Found in SessionsHelper
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    # @user is assigned in the before filter method forthis action.

    respond_to do |format|
      if @user.update_attributes(user_params)
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    puts "destroying user"
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def signed_in_user
      if !signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def user_params
      params.require(:user).permit!
    end
end
