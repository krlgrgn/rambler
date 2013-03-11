require 'spec_helper'

describe "Adventures" do
  describe "listing adventures" do
    context "as a non-signed in user" do
      it "sends the user to the sign in page" do
        visit adventures_path
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
        visit adventures_path # hits /adventures
        page.should have_content "Listing adventures"
      end
      context "administrator" do
        before :each do
          @user = FactoryGirl.create(:user)
          @user.toggle!(:admin)
          @adventure = FactoryGirl.create(:adventure)
        end
        it "lists the available adventures" do
          visit adventures_path # hits /adventures
          page.should have_content "Listing adventures"
        end
      end
    end
  end
  describe "editing an adventure" do
    context "as a non-signed in user" do
      it "sends the user to the sign in page" do
        visit adventures_path
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
          visit adventures_path # hits /adventures
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
          @adventure = FactoryGirl.create(:adventure)
          visit adventures_path # hits /adventures
        end
        it "does not allow the user to edit the adventure" do
          click_link "Edit"
          page.should have_content "StaticPages#home"
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
    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "creates a new adventure and confirms it" do
        visit adventures_url # hits /adventures
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
    end
    context "as a signed in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      context "as the correct user" do
        before :each do
          @adventure = FactoryGirl.create(:adventure, user: @user)
          visit adventures_path # hits /adventures
        end
      end
      context "as the incorrect user" do
        before :each do
          @adventure = FactoryGirl.create(:adventure)
          visit adventures_path # hits /adventures
        end
        it "does not allow the user to delete another users" do
          expect { click_link "Destroy"
          }.to change(Adventure, :count).by(0)

         page.should have_content "StaticPages#home"
        end
      end
      context "administrator" do
        before :each do
          @user.toggle!(:admin)
          sign_in @user
          FactoryGirl.create(:adventure)
        end
        it "allows the admin to destroy an adventure" do
          visit adventures_path # hits /adventures
          expect { click_link "Destroy" }.to change(Adventure, :count).by(-1)
        end
      end
    end
  end
end
