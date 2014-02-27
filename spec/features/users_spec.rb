require 'spec_helper'

describe "Users" do

  describe "signup" do
    context "as a normal user" do
      before :each do
        visit signup_path # Hits /users/new
      end
      it "creates a new user and confirms it" do
        expect {
          fill_in "First Name", with: "Karl"
          fill_in "Last Name", with: "Grogan"
          fill_in "Email", with: "blah@blah.com"
          fill_in "City", with: "Dublin"
          fill_in "State", with: "Dublin"
          fill_in "Country", with: "Ireland"
          fill_in "Password", with: "123456789"
          fill_in "Password Confirmation", with: "123456789"
          click_button "Sign up"
        }.to change(User, :count).by(1)
        page.should have_content "User was successfully created."
      end

      it "wont create a new user if form is submitted with no info" do
        expect {
          click_button "Sign up"
        }.not_to change(User, :count)
      end
    end
    context "as a facebook user" do
      it "creates a new user" do
        pending "create featre test for FB sign in!"
      end
    end
  end

  describe "Authentication" do
    before :each do
      @user = FactoryGirl.create(
        :user,
        email: "sample@sample.com",
        password: "12345678",
        password_confirmation: "12345678"
      )
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
  end

  describe "Authorisation" do

    context "for non-signed in users" do

      describe "attempting to access a protected page" do
        before :each do
          user = FactoryGirl.create(:user)
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with:  user.password
          click_button "Sign in"
        end

        it "should render the desired page after signin in" do
          page.should have_content "Editing user"
        end

      end

      describe "visiting the edit page" do
        let(:user) { FactoryGirl.create(:user) }
        before { visit edit_user_path(user) }

        it "should have a sign in link" do
          page.should have_content "Sign in"

        end
      end

      describe "listing other users" do
        it "should have a sign in link" do
          visit users_path
          page.should have_content "Sign in"
        end
      end

    end

    context "for a signed in user" do

      context "as a non administrative user" do
        describe "listing other users" do
         before :each do
            user = FactoryGirl.create(:user)
            sign_in user
            visit users_path
          end
          it "says listing users" do
            page.should have_content "Listing users"
          end
          it "does not display the destroy link" do
            page.should_not have_content "Destroy"
          end
        end
      end


      context "as an administrative user" do
        describe "listing other users" do
          before :each do
            admin = FactoryGirl.create(:admin)
            sign_in admin
            visit users_path
          end
          it "says listing users" do
            page.should have_content "Listing users"
          end
          it "displays the destroy link for administrative users" do
            page.should have_content "Destroy"
           end
           it "allows the admin user to delete a user" do
             expect {
               click_link "Destroy"
             }.to change(User, :count).by(-1)
          end
        end
      end

      context "as the incorrect user" do
        before :each do
          user = FactoryGirl.create(:user)
          sign_in user
          visit users_path
        end
        describe "editing a users information"
          it "redirects to the root page when the user tries to edit another user\'s information" do
            page.should have_content "Sign out"
            wrong_user = FactoryGirl.create(:user, email: "wrongemail@sample.com")
            visit user_path(wrong_user) # Hits /users/:id
            click_link "Edit"

            # Verify
            page.should have_content("Quest Sign out Messages Create amazing adventures and meet new people!")
          end
      end

      context "as the correct user" do

        before :each do
          @user = FactoryGirl.create(:user)
          sign_in @user
          visit users_path
        end
        describe "editing a users information"

          it "redirects to the users page after a succesful edit" do
            page.should have_content "Sign out"
            visit user_path(@user) # Hits /users/:id
            click_link "Edit"
            page.should have_content "Editing user"
            fill_in "Email", with: "lol@lol.com"
            fill_in "Password", with: "12345678"
            fill_in "Password Confirmation", with: "12345678"
            click_button "Save"

            # Verify
            User.find(@user.id).email.should eq("lol@lol.com")
          end
        end
      end
  end
end
