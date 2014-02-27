require 'spec_helper'

describe User do
  it {should respond_to(:session_token)}

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid when the same email already exists" do
    user = FactoryGirl.create(:user)
    lol = FactoryGirl.build(:user, email: user.email).should_not be_valid
  end

  it "is invalid with an invalid email" do
    FactoryGirl.build(:user, email: "lolol^@lol.com").should_not be_valid
  end

  it "is invalid without a first_name" do
    FactoryGirl.build(:user, first_name: nil).should_not be_valid
  end

  it "is invalid without a last_name" do
    FactoryGirl.build(:user, last_name: nil).should_not be_valid
  end

  it "is invalid without a city" do
    FactoryGirl.build(:user, city: nil).should_not be_valid
  end

  it "is invalid without a state" do
    FactoryGirl.build(:user, state: nil).should_not be_valid
  end

  it "is invalid without a country" do
    FactoryGirl.build(:user, country: nil).should_not be_valid
  end

  it "matches password and password confirmation" do
    user = FactoryGirl.build(:user)
    user.password.should eq(user.password_confirmation)
  end

  it "is invalid if the password and confirmation do not match" do
    FactoryGirl.build(:user, password_confirmation: "lol")
  end

  it "is invalid if password confirmation is nil" do
    FactoryGirl.build(:user, password_confirmation: nil).should_not be_valid
  end

  it "is invalid if password is not present" do
    FactoryGirl.build(:user, password: " ", password_confirmation: " ").should_not be_valid
  end

  it "is invald if a user is created with an administrator role" do
      user = FactoryGirl.create(:user)
      user.roles.map { |r| r.role }
      admin = Role.find_by_role("admin")
      user.reload.roles.should_not include(admin)
  end

  describe "with admin attr set to true" do
    before :each do
      @user = FactoryGirl.create(:admin)
    end

    it "should be an administrator" do
      @user.roles.map { |r| r.role }
      admin = Role.find_by_role("admin")
      @user.reload.roles.should include(admin)
    end
  end

  # User authentication
  describe "authenticating a user" do
    context "using our signup" do
      before :each do
        @user = FactoryGirl.create(:user)
        @found_user = User.find_by_email(@user.email)
      end
      it "should authenticate a valid user" do
        @found_user.authenticate("password").should eq(@user)
      end

      it "should not authenticate an invalid user" do
        @found_user.authenticate("invalid").should_not eq(@user)
      end

      it "is invalid if the password length is less than 8 characters" do
        FactoryGirl.build(:user, password: "123", password_confirmation: "123").should_not be_valid
      end

      it "creates a session token when saving a user" do
        @user.session_token.should_not be_blank
      end
    end
    context "using facebook sigin" do
      before :each do
        @user = FactoryGirl.build(:user,
                                  uid: 1337,
                                  provider: "facebook",
                                  session_token: "This is a token.")
        OmniAuth.config.test_mode = true
        # Create mock omniatuh object.
        @auth = OmniAuth::AuthHash.new({
          "uid" => "1337",
          "provider" => "facebook",
          "info" => {
            "first_name" => @user.first_name,
            "last_name"  => @user.last_name,
            "image"      => @user.image,
            "email" => @user.email
          },
          "credentials" => {
            "token" => "This is a token."
          }
        })
      end
      it "creates a valid facebook user" do
        pending "Waiting for a fix in shoulda matchers for this test."
       # User.from_omniauth(@auth)
       # user = User.where(uid: "1337", provider: "facebook").first
       # user.should_not eq(nil)
       # user.should eq(@user)
       # user.session_token.should_not eq(nil)
      end
      it "returns a FB user specified by the omniatuh response from FB" do
        user = FactoryGirl.create(:user, provider: "facebook", uid: 1337)
        User.from_omniauth(@auth).should eq(user)
      end
    end
  end

  describe "reseting a user's password" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    it "responds to send_password_reset_email" do
      @user.should respond_to(:send_password_reset_email)
    end
    it "responds to find_by_password_reset_token" do
      User.should respond_to(:find_by_password_reset_token)
    end
    describe "finding a user by it's password reset token" do
      it "returns the user for a valid token" do
        token = ActiveSupport::MessageVerifier.new(
          Rails.configuration.secret_token).generate(
            [@user.id,1.day.from_now,@user.password_digest])
        User.find_by_password_reset_token(token).should eq(@user)
      end
      it "returns nil for an invalid token" do
        token = ActiveSupport::MessageVerifier.new(
          Rails.configuration.secret_token).generate(
            [@user.id,1.day.ago,@user.password_digest])
        User.find_by_password_reset_token(token).should eq(nil)
      end
    end
  end
end
