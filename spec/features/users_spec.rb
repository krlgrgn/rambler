require 'spec_helper'

describe "Users" do
  describe "User management" do

    it "creates a new user and redirects to the show action" do
      visit users_url # hits /users
      expect {
        click_link "New User"
        fill_in "First name", with: "Karl"
        fill_in "Last name", with: "Grogan"
        fill_in "Email", with: "blah@blah.com"
        fill_in "City", with: "Dublin"
        fill_in "State", with: "Dublin"
        fill_in "About", with: "Stuff."
        fill_in "Country", with: "Ireland"
        click_button "Save"
      }.to change(User, :count).by(1)
      page.should have_content "User was successfully created."
    end
  end
end
