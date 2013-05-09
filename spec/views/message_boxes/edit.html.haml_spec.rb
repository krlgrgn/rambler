require 'spec_helper'

describe "message_boxes/edit" do
  before(:each) do
    @message_box = assign(:message_box, stub_model(MessageBox,
      :user_id => 1
    ))
  end

  it "renders the edit message_box form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => message_boxes_path(@message_box), :method => "post" do
      assert_select "input#message_box_user_id", :name => "message_box[user_id]"
    end
  end
end
