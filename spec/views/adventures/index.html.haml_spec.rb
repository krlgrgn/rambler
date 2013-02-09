require 'spec_helper'

describe "adventures/index" do
  before(:each) do
    assign(:adventures, [
      stub_model(Adventure,
        :from => "From",
        :to => "To",
        :departure_time => "Departure Time"
      ),
      stub_model(Adventure,
        :from => "From",
        :to => "To",
        :departure_time => "Departure Time"
      )
    ])
  end

  it "renders a list of adventures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "td", :text => "From".to_s, :count => 2
    assert_select "td", :text => "To".to_s, :count => 2
    assert_select "td", :text => "Departure Time".to_s, :count => 2
  end
end
