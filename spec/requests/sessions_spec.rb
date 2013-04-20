require 'spec_helper'

describe "Sessions" do
  before :each do

  end

  describe "GET /sessions/new" do
    it "respondes with a 200 status" do
      get new_session_path
      response.status.should be(200)
    end
  end

  describe "POST /sessions" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    context "with valid user details" do
      it "responds with a 302 status" do
        post sessions_path(), { :session => { :email => @user.email,
                                           :password => @user.password
                                         }
                           }, {}
        response.status.should be(302)
      end
    end
    context "with invalid user_details" do
      it "responds with a 200 status" do
        post sessions_path(), { :session => { :email => "meh@meh.com",
                                           :password => "lolols"
                                         }
                           }, {}
        response.status.should be(200)
      end
    end
  end

  describe "GET /auth/:provider/callback" do
    before :each do
      @user = FactoryGirl.create(:user)
      OmniAuth.config.mock_auth[:facebook] = {
        provider: 'facebook',
        uid: @user.uid,
        credentials: {
            token: 'facebook token'
        }
      }
    end
    context "with valid user details" do
      it "responds with a 302 status" do
        User.stub(:from_omniauth).and_return(@user)
        get fb_create_path('facebook')
        response.status.should be(302)
      end
    end
    context "with invalid user details" do
      it "responds with a 200 status" do
        User.stub(:from_omniauth).and_return(nil)
        get fb_create_path('facebook')
        response.status.should be(200)
      end
    end
  end

  describe "DELETE /sessions" do
    it "responds with a 200 status" do
      delete signout_path
      response.status.should be(302)
    end
  end
end
