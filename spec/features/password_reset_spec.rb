require 'spec_helper'

describe "Password Reset" do
  describe "user accessing password reset page" do
    before :each do
      visit signin_path # Hits /sessions/new
    end
    it "brings the user to the password reset page" do
      click_link "Forgot Password"
      page.should have_content "Email"
    end
  end
  describe "visiting the reset password request page" do
    before :each do
      @user = FactoryGirl.create(:user)
      visit new_password_reset_path # Hits /password_resets/new
    end
    it "redirects to the root page when a user fills out the email form" do
      fill_in "Email", with: @user.email
      click_button "Reset Password"
      page.should have_content "Home Help Sign up Sign in Sigin in with Facebook Create amazing adventures and meet new people!"
    end
  end
  describe "visiting the password reset page" do
    before :each do
      @user = FactoryGirl.create(:user)
      @token = ActiveSupport::MessageVerifier.new(
        Rails.configuration.secret_token).generate(
          [@user.id,1.day.from_now,@user.password_digest])
    end
    it "resets the users password" do
      User.stub(:find_by_password_reset_token).and_return(@user)
      visit edit_password_reset_path(@token)

      fill_in "Password", with: "12345678"
      fill_in "Confirmation", with: "12345678"

      click_button "Save"
      page.should have_content "Home Help Sign up Sign in Sigin in with Facebook Create amazing adventures and meet new people!"
    end
  end
end
