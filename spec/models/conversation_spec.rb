require 'spec_helper'

describe Conversation do
  it "has a valid factory" do
    FactoryGirl.build(:conversation).should be_valid
  end

  describe "converse" do
    it "returns a new or existing conversation" do
      sender = FactoryGirl.create(:user)
      receiver = FactoryGirl.create(:user)
      message = {:body => "asd;alsdka;lskdalkd"}
      Conversation.converse(message, sender, receiver).should
        be_an_instance_of(Conversation)
    end
  end
end
