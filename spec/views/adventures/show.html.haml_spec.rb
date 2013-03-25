require 'spec_helper'

describe "adventures/show" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 1))
    @adventure = assign(:adventure, stub_model(Adventure,
      :from => "From",
      :to => "To",
      :departure_time => "Departure Time",
      :user => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/From/)
    rendered.should match(/To/)
    rendered.should match(/Departure Time/)
  end
end
