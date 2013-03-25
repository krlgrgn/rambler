require 'spec_helper'

describe "adventures/new" do
  before(:each) do
    @user = stub_model(User, :id => 1)
    assign(:user, @user)
    assign(:adventure, stub_model(Adventure,
      :from => "MyString",
      :to => "MyString",
      :departure_time => "MyString",
      :user => @user
    ).as_new_record)
    view.stub!(:current_user).and_return(@user)
  end

  it "renders new adventure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_adventures_path(@user), :method => "post" do
      assert_select "input#adventure_from", :name => "adventure[from]"
      assert_select "input#adventure_to", :name => "adventure[to]"
      assert_select "input#adventure_departure_time", :name => "adventure[departure_time]"
    end
  end
end
