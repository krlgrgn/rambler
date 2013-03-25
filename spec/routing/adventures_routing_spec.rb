require "spec_helper"

describe AdventuresController do
  describe "routing" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    it "routes to #index" do
      get("/users/#{@user.id}/adventures").should route_to("adventures#index", :user_id => @user.id.to_s)
    end

    it "routes to #new" do
      get("/users/#{@user.id}/adventures/new").should route_to("adventures#new", :user_id => @user.id.to_s)
    end

    it "routes to #show" do
      get("/users/#{@user.id}/adventures/1").should route_to("adventures#show", :id => "1", :user_id => @user.id.to_s)
    end

    it "routes to #edit" do
      get("/users/#{@user.id}/adventures/1/edit").should route_to("adventures#edit", :id => "1", :user_id => @user.id.to_s)
    end

    it "routes to #create" do
      post("/users/#{@user.id}/adventures").should route_to("adventures#create", :user_id => @user.id.to_s)
    end

    it "routes to #update" do
      put("users/#{@user.id}/adventures/1").should route_to("adventures#update", :id => "1", :user_id => @user.id.to_s)
    end

    it "routes to #destroy" do
      delete("/users/#{@user.id}/adventures/1").should route_to("adventures#destroy", :id => "1", :user_id => @user.id.to_s)
    end

  end
end
