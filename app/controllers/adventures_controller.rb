class AdventuresController < ApplicationController
  before_filter :adventure_params, :only => [:create, :update]
  
  #
  # This is a declarative authorization method that acts as
  # a before filter. It loads the single resource, an adventure in this case, and
  # checks the access on it.
  # It only operates on the CRUD operations: show, new, edit, create, udpdate.
  #
  filter_resource_access

  # GET /users/1/adventures
  # GET /users/1/adventures.json
  def index
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
    @user = @adventure.user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adventure }
    end
  end

  # GET users/1/adventures/new
  # GET users/1/adventures/new.json
  def new    
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adventure }
    end
  end

  # GET /adventures/1/edit
  def edit
    @user = @adventure.user
  end

  # POST /adventures
  # POST /adventures.json
  def create    
    @adventure.user = current_user

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to user_adventure_path(@adventure.user,@adventure), notice: 'Adventure was successfully created.' }
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
    @user = @adventure.user

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
    @adventure.destroy
    @user = current_user

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
      params.require(:adventure).permit!
    end
end
