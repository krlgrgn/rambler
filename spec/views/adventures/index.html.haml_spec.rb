require 'spec_helper'

describe "adventures/index" do
  before(:each) do
    assign(:adventures, [
      stub_model(Adventure,
        :from => "Dublin",
        :to => "Cork",
        :departure_time => "Time",
        :user => stub_model(User, :id => 1)
      ),
      stub_model(Adventure,
        :from => "Dublin",
        :to => "Cork",
        :departure_time => "Time",
        :user => stub_model(User, :id => 1)
      )
    ])
  end

  it "renders a list of adventures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "td", :text => "Dublin", :count => 2
    assert_select "td", :text => "Cork", :count => 2
    assert_select "td", :text => "Time", :count => 2
  end
end
