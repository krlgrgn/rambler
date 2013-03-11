require 'spec_helper'

describe Adventure do

  it "has a valid factory" do
    FactoryGirl.create(:adventure).should be_valid
  end
  it "is invalid without an associated user" do
    FactoryGirl.build(:adventure, user: nil).should_not be_valid
  end
  it "is invalid without a city of origin" do
    FactoryGirl.build(:adventure, from: nil).should_not be_valid
  end
  it "is invalid without a destination" do
    FactoryGirl.build(:adventure, to: nil).should_not be_valid
  end
  it "is valid without a departure time" do
    FactoryGirl.build(:adventure, departure_time: nil).should be_valid
  end

end
