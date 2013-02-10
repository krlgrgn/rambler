require 'spec_helper'

describe StaticPagesController do
  describe "routing" do
    it "routes to #home" do
      get("/").should route_to("static_pages#home")
    end
    it "routes to #help" do
      get("/help").should route_to("static_pages#help")
    end
  end
end
