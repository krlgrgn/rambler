require "spec_helper"

describe MailboxesController do
  describe "routing" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    #it "routes to #index" do
      #get("/message_boxes").should route_to("message_boxes#index")
    #end

    #it "routes to #new" do
      #get("/message_boxes/new").should route_to("message_boxes#new")
    #end

    it "routes to #show" do
      get("/users/#{@user.id}/mailbox").should route_to("mailboxes#show", :user_id => @user.id.to_s)
    end

    #it "routes to #edit" do
      #get("/message_boxes/1/edit").should route_to("message_boxes#edit", :id => "1")
    #end

    #it "routes to #create" do
      #post("/message_boxes").should route_to("message_boxes#create")
    #end

    #it "routes to #update" do
      #put("/message_boxes/1").should route_to("message_boxes#update", :id => "1")
    #end

    #it "routes to #destroy" do
      #delete("/message_boxes/1").should route_to("message_boxes#destroy", :id => "1")
    #end

  end
end
