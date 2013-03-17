require 'spec_helper'

describe "Adventures" do
  before :each do
    @adventure = FactoryGirl.create(:adventure)
    @user = FactoryGirl.create(:user)
  end
  describe "GET /adventures" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get adventures_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get adventures_path
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get adventure_path(@adventure)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get adventure_path(@adventure)
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/new" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get new_adventure_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get new_adventure_path
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/:id/edit" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get edit_adventure_path(:id => @adventure.id, :user_id => @user.id)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get edit_adventure_path(@adventure)
        response.status.should be(302)
      end
    end
  end
  describe "POST /adventures" do
    before :each do
      @new_adventure = FactoryGirl.attributes_for(:adventure)
    end
    context "as a signed in user" do
      it "responds with a 200 status" do
        post adventures_path, { :adventure => @new_adventure, :user_id => @user.id }, {}
        response.status.should be(302)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        post adventures_path, { :adventure => @new_adventure, :user_id => @user.id}, {}
        response.status.should be(302)
      end
    end
  end
  describe "PUT /adventure/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        Adventure.any_instance.should_receive(:update_attributes).with({ "state" => "a state" })
        put adventure_path(@adventure), {:id => @adventure.to_param, :adventure => { "state" => "a state" }, :user_id => @user.id}
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        put adventure_path(@adventure), {:id => @adventure.to_param, :user => { "state" => "a state" }, :user_id => @user.id}
        response.status.should be(302)
      end
    end
  end
end
