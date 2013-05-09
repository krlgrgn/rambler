require 'spec_helper'

describe MessageBox do
  it "has a valid factory" do
    FactoryGirl.create(:message_box).should be_valid
  end

  it "is invalid without a user_id" do
    FactoryGirl.build(:message_box, user: nil).should_not be_valid
  end
end
