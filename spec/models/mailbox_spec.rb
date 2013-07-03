require 'spec_helper'

describe Mailbox do
  it "has a valid factory" do
    FactoryGirl.create(:mailbox).should be_valid
  end

  it "is invalid without a user_id" do
    FactoryGirl.build(:mailbox, user: nil).should_not be_valid
  end
end
