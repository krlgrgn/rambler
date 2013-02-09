require 'spec_helper'

describe "Users" do
  describe "User management" do

    it "creates a new user and confirms it" do
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
    
    it "edits an existing user and redirects and confirms it" do
      user = FactoryGirl.create(:user)
      visit "/users/#{user.id}"
      click_link "Edit"
      page.should have_content "Editing user"
      fill_in "Email", with: "lol@lol.com"
      click_button "Save"
      User.find(user.id).email.should eq("lol@lol.com")
    end

    it "deletes a user and redirects to a page listing the users" do
      user = FactoryGirl.create(:user)
      visit users_url
      expect {
          click_link "Destroy"
      }.to change(User, :count).by(-1)
      page.should have_content "Listing users"
    end
  end
end
