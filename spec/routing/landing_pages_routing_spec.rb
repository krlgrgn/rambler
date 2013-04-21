require "spec_helper"

describe LandingPagesController do
  describe "routing" do

    it "routes to #new" do
      get("/landing_pages/new").should route_to("landing_pages#new")
    end

    it "routes to #create" do
      post("/landing_pages").should route_to("landing_pages#create")
    end

    it "root routes to #new" do
      get("/").should route_to("landing_pages#new")
    end

  end
end
