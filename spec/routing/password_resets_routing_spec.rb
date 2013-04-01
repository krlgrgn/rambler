require "spec_helper"

describe PasswordResetsController do
  describe "routing" do
    it "routes to #new" do
      get("/password_resets/new").should route_to("password_resets#new")
    end
    it "routes to #edit" do
      get("/password_resets/1231f1ddw/edit").should route_to("password_resets#edit", :id => "1231f1ddw")
    end
    it "routes to #create" do
      post("/password_resets").should route_to("password_resets#create")
    end
    it "routes to #update" do
      put("/password_resets/123djaij22").should route_to("password_resets#update", :id => "123djaij22")
    end
  end
end
