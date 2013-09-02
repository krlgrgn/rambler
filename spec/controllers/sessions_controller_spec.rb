require 'spec_helper'

describe SessionsController do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl.attributes_for(:user, password: "12345678",
                              password_confirmation: "12345678")
  end

  describe "GET new" do
    it "renders the new template" do
      get :new, {}
      response.should render_template("new")
    end
  end

  describe "POST create"do
    before :each do
      @user = User.create! valid_attributes
      post :create, { :session => {
                        :email =>  @user.email,
                        :password => "12345678"
                      }
                    }
    end
    context "with valid params" do
      before :each do
        post :create, { :session => {
                          :email =>  @user.email,
                          :password => "12345678"
                        }
                      }
      end
      it "assigns the user as user" do
        assigns(:user).should eq(@user)
      end

      it "authenticates the user" do
        response.should redirect_to(@user)
      end
    end
    context "with invalid params" do
      before :each do
        post :create, { :session => {
                          :email =>  "derp@derp.com",
                          :password => "12345678"
                        }
                      }
      end
      it "renders the new template" do
        response.should render_template("new")
      end
    end
  end

  describe "GET fb_create" do
    before :each do
      @user = User.create! valid_attributes
      OmniAuth.config.mock_auth[:facebook] = {
        provider: 'facebook',
        uid: @user.uid,
        credentials: {
            token: 'facebook token'
        }
      }
      User.stub(:from_omniauth).and_return(@user)
      get :fb_create, {:provider => 'facebook'}
    end
    it "assigns the user as user" do
      assigns(:user).should eq(@user)
    end
    it "authenticates the user" do
      response.should redirect_to(@user)
    end
  end

  describe "DELETE destroy" do
    before :each do
      @user = User.create! valid_attributes
      cookies['session_token'] = @user.session_token
      controller.stub(:current_user).and_return(@user)
      delete :destroy, {}
    end
    it "should sign out the user" do
      cookies['session_token'].should eq(nil)
      # TODO: Figure out how to test that the current_user
      # is nil.
    end
    it "should redirect to the root url" do
      response.should redirect_to(root_path)
    end
  end
end
