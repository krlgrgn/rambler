class MessageBoxesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user

  # GET /message_boxes/1
  # GET /message_boxes/1.json
  def show
    @user = User.find(params[:user_id])
    @message_box = @user.message_box

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_box }
    end
  end

  # GET /message_boxes/new
  # GET /message_boxes/new.json
  #def new
    #@message_box = MessageBox.new
#
    #respond_to do |format|
      #format.html # new.html.erb
      #format.json { render json: @message_box }
    #end
  #end

  # GET /message_boxes/1/edit
  #def edit
    #@message_box = MessageBox.find(params[:id])
  #end

  # POST /message_boxes
  # POST /message_boxes.json
  #def create
    #@message_box = MessageBox.new(params[:message_box])
#
    #respond_to do |format|
      #if @message_box.save
        #format.html { redirect_to @message_box, notice: 'Message box was successfully created.' }
        #format.json { render json: @message_box, status: :created, location: @message_box }
      #else
        #format.html { render action: "new" }
        #format.json { render json: @message_box.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # PUT /message_boxes/1
  # PUT /message_boxes/1.json
  #def update
    #@message_box = MessageBox.find(params[:id])
#
    #respond_to do |format|
      #if @message_box.update_attributes(params[:message_box])
        #format.html { redirect_to @message_box, notice: 'Message box was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: "edit" }
        #format.json { render json: @message_box.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /message_boxes/1
  # DELETE /message_boxes/1.json
  #def destroy
    #@message_box = MessageBox.find(params[:id])
    #@message_box.destroy

    #respond_to do |format|
      #format.html { redirect_to message_boxes_url }
      #format.json { head :no_content }
    #end
  #end

  private
    def signed_in_user
      if !signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      #user_id is the user ID associated with the adventure(s)
      user = User.find(params[:user_id])
      redirect_to root_path if !current_user?(user)
    end
end
