require 'spec_helper'

describe LandingPage do
  it "has a valid factory" do
    FactoryGirl.create(:landing_page).should be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:landing_page, email: nil).should_not be_valid
  end

  it "is invalid when the same email already exists" do
    landing_page = FactoryGirl.create(:landing_page)
    lol = FactoryGirl.build(:landing_page, email: landing_page.email).
            should_not be_valid
  end

  it "is invald with an invalid email address" do
    FactoryGirl.build(:landing_page, email: "lol^@lol.com").should_not be_valid
  end
end
