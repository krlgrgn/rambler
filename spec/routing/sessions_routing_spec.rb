require "spec_helper"

describe SessionsController do
  describe "routing" do
  	it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/signin").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #destroy" do
      delete("/signout").should route_to("sessions#destroy")
    end

    it "routes to #fb_create" do
      get("/auth/facebook/callback").should route_to("sessions#fb_create", :provider => "facebook")
    end
  end
end
