require 'spec_helper'

describe "Adventures" do
  describe "listing adventures" do
    context "as a non-signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      it "sends the user to the sign in page" do
        visit user_adventures_path(@user)
        page.should_not have_content "Listing adventures"
        page.should have_content "Sign in"
      end
    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "lists the available adventures" do
        visit user_adventures_path(@user) # hits /users/:user_id/adventures
        page.should have_content "Listing adventures"
      end
      context "administrator" do
        before :each do
          @user = FactoryGirl.create(:user)
          @user.toggle!(:admin)
          @adventure = FactoryGirl.create(:adventure)
        end
        it "lists the available adventures" do
          visit user_adventures_path(@user) # hits /users/:user_id/adventures
          page.should have_content "Listing adventures"
        end
      end
    end
  end
  describe "editing an adventure" do
    context "as a non-signed in user" do
      it "sends the user to the sign in page" do
        visit user_adventures_path(FactoryGirl.create(:user))
        page.should_not have_content "Editing adventure"
        page.should have_content "Sign in"
      end
    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      context "as the correct user" do
        before :each do
          @adventure = FactoryGirl.create(:adventure, user: @user)
          visit user_adventures_path(@user) # Hits /users/:user_id/adventures
        end
        it "it allows the user to edit the adventure" do
          click_link "Edit"
          page.should have_content "Editing adventure"
          fill_in "From", with: "LOLTown"
          click_button "Save"
          Adventure.find(@adventure.id).from.should eq("LOLTown")
        end
      end
      context "as the incorrect user" do
        before :each do
          user = FactoryGirl.create(:user)
          @adventure = FactoryGirl.create(:adventure, user: user)
          visit user_adventures_path(user) # Hits /users/:user_id/adventures
        end
        it "does not allow the user to edit the adventure" do
          click_link "Edit"
          page.should have_content "Home Help Sign out Messages Create amazing adventures and meet new people!"
        end
      end
      context "administrator" do
        before :each do
          @user.toggle!(:admin)
        end
        it "does not allow the admin to edit the adventure" do
          click_link "Edit"
          page.should_not have_content "Editing adventure"
        end
      end
    end
  end
  describe "creating a new adventure" do
    context "as a non-signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
      end
       it "sends the user to the sign in page" do
        visit user_adventures_path(@user)
        page.should_not have_content "New adventure"
        page.should have_content "Sign in"
      end

    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "creates a new adventure and confirms it" do
        visit user_adventures_path(@user) # Hits /users/:user_id/adventures/new
        expect {
          click_link "New Adventure"
          fill_in "From", with: "Dublin"
          fill_in "To", with: "Maynooth"
          fill_in "Departure time", with: nil
          click_button "Save"
        }.to change(Adventure, :count).by(1)
        page.should have_content "Adventure was successfully created."
      end
      context "administrator" do
        before :each do
          @user = FactoryGirl.create(:user)
          @user.toggle!(:admin)
          sign_in @user
          @adventure = FactoryGirl.create(:adventure)
        end
      end
    end
  end
  describe "destroying an adventure" do
    context "as a non-signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
      end
       it "sends the user to the sign in page" do
        adventure = FactoryGirl.create(:adventure, user: @user)
        visit user_adventures_path(@user)
        page.should_not have_content "Destroy"
        page.should have_content "Sign in"
      end

    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      context "as the correct user" do
        before :each do
          @adventure = FactoryGirl.create(:adventure, user: @user)
        end
        it "allows the user to destroy an adventure" do
          visit user_adventures_path(@user) # Hits /users/:user_id/adventures
          expect { click_link "Destroy" }.to change(Adventure, :count).by(-1)
        end
      end
      context "as the incorrect user" do
        before :each do
          user = FactoryGirl.create(:user)
          @adventure = FactoryGirl.create(:adventure, user: user)
          visit user_adventures_path(user) # Hits /users/:user_id/adventures
        end
        it "does not allow the user to delete another users" do
          expect { click_link "Destroy"}.to change(Adventure, :count).by(0)
          page.should have_content "ome Help Sign out Messages Create amazing adventures and meet new people!"
        end
      end
      context "administrator" do
        before :each do
          @user.toggle!(:admin)
          other_user = FactoryGirl.create(:user)
          FactoryGirl.create(:adventure, user: other_user)
          sign_in @user
          visit user_adventures_path(other_user) # Hits /users/:user_id/adventures
        end
        it "does not allow the admin to destroy an adventure" do
          expect { click_link "Destroy" }.to change(Adventure, :count).by(0)
        end
      end
    end
  end
end
