require 'spec_helper'

describe User do
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
    FactoryGirl.build(:user, email: "lolol^@lol.com")
  end

  it "is invalid without a first_name" do
    FactoryGirl.build(:user, first_name: nil)
  end

  it "is invalid without a last_name" do
    FactoryGirl.build(:user, last_name: nil)
  end

  it "is invalid without a city" do
    FactoryGirl.build(:user, city: nil)
  end

  it "is invalid without a state" do
    FactoryGirl.build(:user, state: nil)
  end

  it "is invalid without a country" do
    FactoryGirl.build(:user, country: nil)
  end
end
