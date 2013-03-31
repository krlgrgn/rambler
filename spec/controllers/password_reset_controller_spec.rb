require 'spec_helper'

describe PasswordResetsController do
  describe "GET new" do
    it "renders the new tamplate" do
      get :new, {}
    end
  end

  describe "GET edit" do
    it "assigns a user as @user" do
      user = FactoryGirl.create(:user)
      token = ActiveSupport::MessageVerifier.new(
        Rails.configuration.secret_token).generate(
          [user.id,1.day.from_now,user.password_digest])

      get :edit, { :id => token }
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:user)
      post :create, { :password_reset => { :email => user.email } }
      assigns(:user).should eq(user)
    end
    it "sends a password reset email" do
      user = FactoryGirl.create(:user)
      User.any_instance.should_receive(:send_password_reset_email)
      post :create, { :password_reset => { :email => user.email } }
    end
  end

  describe "PUT update" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    context "with valid params" do
      before :each do
        User.stub(:find_by_password_reset_token).
          and_return(@user)
      end
      it "assigns the request user as @user" do
        put :update, {:id => @user.to_param, :user => { "state" => "a state" }}
        assigns(:user).should eq(@user)
      end
      it "updates the request user" do
        User.any_instance.should_receive(:update_attributes).with({
          "state" => "a state"
        })
        put :update, {:id => @user.to_param, :user => { "state" => "a state" }}
      end
      it "redirecs to the root path" do
        put :update, {:id => @user.to_param, :user => { "state" => "a state" }}
        response.should redirect_to(root_path)
      end
    end
    context "with invalid params" do
      before :each do
        @user = FactoryGirl.create(:user)
        User.stub(:find_by_password_reset_token).
          and_return(nil)
      end
      it "assigns the user as @user" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => @user.to_param, :user => { "state" => "a state" }}
        assigns(:user).should eq(nil)
      end
      it "renders the edit template" do
        put :update, {:id => @user.to_param, :user => { "state" => "a state" }}
        response.should render_template("edit")
      end
    end
  end
end
