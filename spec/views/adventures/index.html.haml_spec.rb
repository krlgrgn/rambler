require 'spec_helper'

describe "adventures/index" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 1))
    assign(:adventures, [
      stub_model(Adventure,
        :from => "Dublin",
        :to => "Cork",
        :departure_time => "14:00",
        :user => @user
      ),
      stub_model(Adventure,
        :from => "Galway",
        :to => "Belfast",
        :departure_time => "15:00",
        :user => @user
      )
    ])
    view.stub!(:current_user).and_return(@user)
  end

  it "renders a list of adventures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "td", :text => "Dublin", :count => 1
    assert_select "td", :text => "Cork", :count => 1
    assert_select "td", :text => "Belfast", :count => 1
    assert_select "td", :text => "Galway", :count => 1
    assert_select "td", :text => "14:00", :count => 1
    assert_select "td", :text => "15:00", :count => 1
  end
end
