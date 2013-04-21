require 'spec_helper'

describe "LandingPages" do
  describe "GET /landing_pages/new" do
    it "responds with a 200 status" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get new_landing_page_path
      response.status.should be(200)
    end
  end
  describe "POST /landing_pages" do
    context "with valid params" do
      it "responds with a 302 status" do
        landing_page = FactoryGirl.attributes_for(:landing_page)
        post landing_pages_path, { :landing_page => landing_page }
        response.status.should be(302)
      end
    end
    context "with invalid params" do
      it "responds with a 200 status" do
        landing_page = FactoryGirl.attributes_for(:landing_page, email: "lol^@lol.com")
        post landing_pages_path, { :landing_page => landing_page }
        response.status.should be(200)
      end
    end
  end
end
