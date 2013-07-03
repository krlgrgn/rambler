class MessagesController < ApplicationController
  before_filter :signed_in_user

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    # TODO: Refactor whole method.
    # Maybe do this instead?
    # Check for instance of conversation
    # if true: retrieve conversation and its participants; reply with a mesage
    # if false: set up the conversation.
    @recipient = User.find(params[:recipient])

    # Stop sending a message to yourself.....
    # TODO: Rethink this...
    if current_user == @recipient
      redirect_to @recipient, notice: 'You cannot send a message to yourself.' and return
    end

    # TODO: Refactor. We should create an instance of message first and see if
    # its valid or not.
    if params[:message][:body].empty?
        redirect_to @recipient, notice: "Message cannot be empty." and return
    end

    @conversation = Conversation.converse(
                      params[:message],
                      current_user,
                      @recipient)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @recipient, notice: 'Message was successfully created.' }
        format.json { render json: @recipient, status: :created, location: @recipient }
      else
        format.html { redirect_to @recipient }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
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
      @user = User.find(params[:user_id])
      redirect_to root_path if !current_user?(user)
    end
end
