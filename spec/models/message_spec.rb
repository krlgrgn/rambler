require 'spec_helper'

describe Message do
  it "has a valid factory" do
    FactoryGirl.build(:message).should be_valid
  end
  it "is invalid without a message body" do
    FactoryGirl.build(:message, body: nil).should_not be_valid
  end
  it "is invalid without a conversation_id" do
    FactoryGirl.build(:message, conversation: nil).should_not be_valid
  end
  it "is invalid without a user_id" do
    FactoryGirl.build(:message, user: nil).should_not be_valid
  end
end
