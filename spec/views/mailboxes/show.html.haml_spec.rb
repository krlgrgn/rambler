require 'spec_helper'

describe "mailboxes/show" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id =>1))
    @mailbox = assign(:mailbox, FactoryGirl.create(:mailbox_with_conversations))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/1/)
  end
end
