require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end

    pending "Write a test for redirecting to signin in page for non signed in users"
    pending "Write a test for signed in users editing information"
  end
end
