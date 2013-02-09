require 'spec_helper'

describe "Adventures" do

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

  it "edits an existing adventure and confirms it" do
    adventure = FactoryGirl.create(:adventure)
    visit "/adventures/#{adventure.id}"
    click_link "Edit" 
    page.should have_content "Editing adventure"
    fill_in "From", with: "LOLTown"
    click_button "Save"
    Adventure.find(adventure.id).from.should eq("LOLTown") 
  end
  it "deletes an adventure and redirects to a page listing the adventures" do
    adventure = FactoryGirl.create(:adventure)
    visit adventures_url
    expect { click_link "Destroy" }.to change(Adventure, :count).by(-1)
    page.should have_content "Listing adventures"
  end
end
