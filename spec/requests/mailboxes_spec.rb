require 'spec_helper'

describe "MessageBoxes" do
  before :each do
    @user = FactoryGirl.create(:user)
    @mailbox = FactoryGirl.create(:mailbox, :user => @user)
    @conversation = FactoryGirl.create(:conversation)
    @convo_mail_map = FactoryGirl.create(:conversation_mailbox_map, mailbox: @mailbox, conversation: @conversation)
    @message = FactoryGirl.create(:message, user: @user, conversation: @conversation)
  end
  describe "GET /message_boxes" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        cookies['session_token'] = @user.session_token
        get user_mailbox_path(@user)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get user_mailbox_path(@user)
        response.status.should be(302)
      end

    end
  end
end
