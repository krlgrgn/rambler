require 'spec_helper'

describe "message_boxes/index" do
  before(:each) do
    assign(:message_boxes, [
      stub_model(MessageBox,
        :user_id => 1
      ),
      stub_model(MessageBox,
        :user_id => 1
      )
    ])
  end

  it "renders a list of message_boxes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
