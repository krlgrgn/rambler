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

  it "is invald if a user is create with admin as a parameter" do
    FactoryGirl.build(:user).admin.should be_nil
  end

  describe "with admin attr set to true" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "should be an administrator" do
      @user.toggle!(:admin)
      @user.reload.admin.should eq true
    end
  end

  # User authentication
  describe "authenticating a user" do
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
end
