require 'spec_helper'

describe "adventures/edit" do
  before(:each) do
    @adventure = assign(:adventure, stub_model(Adventure,
      :from => "MyString",
      :to => "MyString",
      :departure_time => "MyString"
    ))
  end

  it "renders the edit adventure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adventures_path(@adventure), :method => "post" do
      assert_select "input#adventure_from", :name => "adventure[from]"
      assert_select "input#adventure_to", :name => "adventure[to]"
      assert_select "input#adventure_departure_time", :name => "adventure[departure_time]"
    end
  end
end
