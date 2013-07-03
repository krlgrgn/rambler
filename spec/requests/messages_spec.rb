require 'spec_helper'

describe "Messages" do
  before :each do
    @user = FactoryGirl.create(:user)
    @recipient = FactoryGirl.create(:user)
    @conversation = FactoryGirl.create(:conversation)
    @message = FactoryGirl.create(:message, user: @user, conversation: @conversation)
  end
  describe "GET /messages" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get messages_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get messages_path
        response.status.should be(302)
      end
    end
  end
  describe "GET /messages/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get message_path(@message)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get message_path(@message)
        response.status.should be(302)
      end
    end
  end
  describe "GET /messages/new" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get new_message_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get new_message_path
        response.status.should be(302)
      end
    end
  end
  describe "POST /messages" do
    context "as a signed in user" do
      it "responds with a 302 status" do
        cookies['session_token'] = @user.session_token
        post messages_path, { :message => { :body => @message.body }, :recipient => @recipient.id }, {}
        response.status.should be(302)
      end

      context "when the user is the recipient" do
        it "responds with a 302 status" do
        cookies['session_token'] = @user.session_token
        post messages_path, { :message => { :body => @message.body }, :recipient => @user.id }, {}
        response.status.should be(302)
        end
      end

      context "when the message body is empty" do
        it "responds with a 302 status" do
          cookies['session_token'] = @user.session_token
          post messages_path, { :message => { :body => "" }, :recipient => @recipient.id }, {}
          response.status.should be(302)
        end
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        post messages_path, { :message => { :body => @message.body }, :recipient => @recipient }
        response.status.should be(302)
      end
    end
  end
end
