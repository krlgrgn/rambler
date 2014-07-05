require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User),
      stub_model(User)
    ])

    user = stub_model(User, :id => 1)

    # Had to stub the current_user because the `permited_to?` is calling
    # some current_user method defined within declarative_authorization which
    # is available through the controller.
    controller.stub(:current_user).and_return(user)
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
