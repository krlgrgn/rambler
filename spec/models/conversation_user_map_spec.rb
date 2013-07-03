require 'spec_helper'

describe ConversationUserMap do
  describe "checking when a conversation exists" do
    before :each do
      @convo = FactoryGirl.create(:conversation)
      @sender = FactoryGirl.create(:user)
      @receiver = FactoryGirl.create(:user)
      FactoryGirl.create(
        :conversation_user_map, user: @sender, conversation: @convo)
      FactoryGirl.create(
        :conversation_user_map, user: @receiver, conversation: @convo)
    end

    it "returns the conversation if it exists bewteen two users" do
      ConversationUserMap.conversation_exists?(@sender, @receiver).should eq(@convo)
    end

    it "returns nil if no conversation exists between two users" do
      fake_receiver = FactoryGirl.create(:user)
      ConversationUserMap.conversation_exists?(
        @sender, fake_receiver).should eq(nil)
    end

    it "raises an Exception if more than two entries for the user mapping exists" do
      pending("Write a proper test for this or not, because this situation
              should not occur.")
    end
  end
end
