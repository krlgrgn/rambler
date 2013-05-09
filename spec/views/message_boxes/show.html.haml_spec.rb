require 'spec_helper'

describe "message_boxes/show" do
  before(:each) do
    @message_box = assign(:message_box, stub_model(MessageBox,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
