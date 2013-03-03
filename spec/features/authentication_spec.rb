require 'spec_helper'

describe "Authentication" do

  describe "signin page" do
    it "should have sign in on the page" do
      visit signin_path # Hits /signin
      page.should have_content "Sign in"
    end

    it "signs in a user with valid credentials" do
      user = FactoryGirl.create(:user)
      visit signin_path # Hits /signin
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Sign in"
    end

    it "does not sign in a user with invalid credentials" do
      visit signin_path # Hits /signin
      click_button "Sign in"
      page.should_not have_content "Logout"
    end
  end

end
