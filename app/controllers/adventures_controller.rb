class AdventuresController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy, :create]

  # GET /users/1/adventures
  # GET /users/1/adventures.json
  def index
    # Assigning @user as the current user and then looking up the adventures
    # that the user has will always return the currently signed in users
    # adventures regardless of the user_id passed in the url/params.
    @user = User.find(params[:user_id])
    @adventures = @user.adventures

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adventures }
    end
  end

  # GET /users/1/adventures/1
  # GET /users/1/adventures/1.json
  def show
    @user = User.find(params[:user_id])
    @adventure = @user.adventures.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adventure }
    end
  end

  # GET /adventures/new
  # GET /adventures/new.json
  def new
    @adventure = Adventure.new
    # If we had used user_id as a parameter here, we could've created an adventure
    # for the user specified by user_id, rather than the current user.
    # TODO: I could use user_id here and let the correct_user filter handle it?
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adventure }
    end
  end

  # GET /adventures/1/edit
  def edit
    @adventure = @user.adventures.find(params[:id])
  end

  # POST /adventures
  # POST /adventures.json
  def create
    #@user = User.find(params[:user_id])
    @adventure = @user.adventures.build(adventure_params)

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to user_adventure_path(@user,@adventure), notice: 'Adventure was successfully created.' }
        format.json { render json: @adventure, status: :created, location: @adventure }
      else
        format.html { render action: "new" }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adventures/1
  # PUT /adventures/1.json
  def update
    @adventure = @user.adventures.find(params[:id])

    respond_to do |format|
      if @adventure.update_attributes(adventure_params)
        format.html { redirect_to user_adventure_path(@user, @adventure), notice: 'Adventure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure = @user.adventures.find(params[:id])
    @adventure.destroy

    respond_to do |format|
      format.html { redirect_to user_adventures_path(@user) }
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

    def correct_user
      #user_id is the user ID associated with the adventure(s)
      # i.e. the guy that created the adventure.
      user = User.find(params[:user_id])
      if !current_user?(user)
        redirect_to root_path
      else
        @user = user
      end
    end

    def adventure_params
      params.require(:adventure).permit(:from, :to, :departure_time, :user, :user_id)
    end
end
