require 'spec_helper'

describe "Users" do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  describe "GET /users" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get users_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get users_path
        response.status.should be(302)
      end
    end
  end
  describe "GET /users/:id" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get user_path @user
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get user_path @user
        response.status.should be(302)
      end
    end
  end
  describe "GET /users/new" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get new_user_path
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 200 status" do
        get new_user_path
        response.status.should be(200)
      end
    end
  end
  describe "GET /users/:id/edit" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        get edit_user_path @user
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        get edit_user_path @user
        response.status.should be(302)
      end
    end
  end
  describe "POST /users" do
    before :each do
      @new_user = FactoryGirl.attributes_for(:user)
    end
    context "as a signed in user" do
      it "responds with a 200 status" do
        post users_path, { :user => @new_user }, {}
        response.status.should be(302)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 200 status" do
        post users_path, { :user => @new_user }, {}
        response.status.should be(302)
      end
    end
  end
  describe "PUT /users" do
    context "as a signed in user" do
      it "responds with a 200 status" do
        cookies['session_token'] = @user.session_token
        User.any_instance.should_receive(:update_attributes).with({ "state" => "a state" })
        put user_path(@user), {:id => @user.to_param, :user => { "state" => "a state" }}
        response.status.should be(200)
      end
    end
    context "as a non-signed in user" do
      it "responds with a 302 status" do
        put user_path(@user), {:id => @user.to_param, :user => { "state" => "a state" }}
        response.status.should be(302)
      end
    end
  end
end
