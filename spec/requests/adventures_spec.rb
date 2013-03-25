require 'spec_helper'

describe "Adventures" do
  before :each do
    @user = FactoryGirl.create(:user)
    @adventure = FactoryGirl.create(:adventure, :user => @user)
  end
  describe "GET /adventures" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get user_adventures_path(@user)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get user_adventures_path(@user)
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get user_adventure_path(@user, @adventure)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get user_adventure_path(@user, @adventure)
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/new" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get new_user_adventure_path(@user)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get new_user_adventure_path(@user)
        response.status.should be(302)
      end
    end
  end
  describe "GET adventures/:id/edit" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get edit_user_adventure_path(@user, @adventure)
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get edit_user_adventure_path(@user, @adventure)
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
        post user_adventures_path(@user), { :adventure => @new_adventure, :user_id => @user.id }, {}
        response.status.should be(302)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        post user_adventures_path(@user), { :adventure => @new_adventure, :user_id => @user.id}, {}
        response.status.should be(302)
      end
    end
  end
  describe "PUT /adventure/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        Adventure.any_instance.should_receive(:update_attributes).with({ "state" => "a state" })
        put user_adventure_path(@user, @adventure), {:id => @adventure.to_param, :adventure => { "state" => "a state" }, :user_id => @user.id}
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        put user_adventure_path(@user, @adventure), {:id => @adventure.to_param, :user => { "state" => "a state" }, :user_id => @user.id}
        response.status.should be(302)
      end
    end
  end
end
