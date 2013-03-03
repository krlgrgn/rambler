require 'spec_helper'

describe "Users" do

  describe "signup" do
    before :each do
      visit signup_path # Hits /users/new
    end

    it "creates a new user and confirms it" do
      expect {
        fill_in "First name", with: "Karl"
        fill_in "Last name", with: "Grogan"
        fill_in "Email", with: "blah@blah.com"
        fill_in "City", with: "Dublin"
        fill_in "State", with: "Dublin"
        fill_in "About", with: "Stuff."
        fill_in "Country", with: "Ireland"
        fill_in "Password", with: "123456789"
        fill_in "Confirmation", with: "123456789"
        click_button "Save"
      }.to change(User, :count).by(1)
      page.should have_content "User was successfully created."
    end

    it "wont create a new user if form is submitted with no info" do
      expect {
        click_button "Save"
      }.not_to change(User, :count)
    end
  end

  describe "Authentication" do
    before :each do
      @user = FactoryGirl.create(:user, email: "sample@sample.com", password: "12345678", password_confirmation: "12345678")
      visit root_path
    end

    it "signs in a user" do
      @user.session_token.should_not be_empty
      sign_in @user
      page.should have_content "Sign out"
      page.should_not have_content "Sign in"
    end

    it "signs out a user" do
      sign_in @user
      click_link "Sign out"
      page.should_not have_content "Sign out"
      page.should have_content "Sign in"
    end

    describe "authorisation" do
      let(:user) { FactoryGirl.create(:user) }


      describe "for non-signed in users" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it "should have a sign in link" do
            page.should have_content "Sign in"
          end
        end
      end

      describe "for a signed in user" do
        pending "write test for editing a users information."
      end
    end
  end

  describe "User management" do
    before :each do
      @user = FactoryGirl.create(:user, password: "12345678", password_confirmation: "12345678")
    end

    it "edits an existing user and redirects and confirms it" do
      sign_in @user
      page.should have_content "Sign out"
      visit user_path(@user) # Hits /users/:id
      click_link "Edit"
      page.should have_content "Editing user"
      fill_in "Email", with: "lol@lol.com"
      fill_in "Password", with: "12345678"
      fill_in "Confirmation", with: "12345678"
      click_button "Save"
      User.find(@user.id).email.should eq("lol@lol.com")
    end

    it "deletes a user and redirects to a page listing the users" do
      visit users_path
      expect {
          click_link "Destroy"
      }.to change(User, :count).by(-1)
      page.should have_content "Listing users"
    end
  end
end
