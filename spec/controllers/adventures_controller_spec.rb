require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AdventuresController do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
    cookies['session_token'] = @user.session_token
  end

  # This should return the minimal set of attributes required to create a valid
  # Adventure. As you add validations to Adventure, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
   FactoryGirl.attributes_for(:adventure).merge(user_id: @user.id)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdventuresController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all adventures as @adventures" do
      adventure = Adventure.create! valid_attributes
      get :index, {}
      assigns(:adventures).should eq([adventure])
    end
  end

  describe "GET show" do
    it "assigns the requested adventure as @adventure" do
      adventure = Adventure.create! valid_attributes
      get :show, {:id => adventure.to_param}, valid_session
      assigns(:adventure).should eq(adventure)
    end
  end

  describe "GET new" do
    it "assigns a new adventure as @adventure" do
      get :new, {}, valid_session
      assigns(:adventure).should be_a_new(Adventure)
    end
  end

  describe "GET edit" do
    it "assigns the requested adventure as @adventure" do
      adventure = Adventure.create! valid_attributes
      get :edit, {:id => adventure.to_param, :user_id => @user.id}, valid_session
      assigns(:adventure).should eq(adventure)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Adventure" do
        expect {
          post :create, {:adventure => valid_attributes.except(:user_id), :user_id => @user.id}
        }.to change(Adventure, :count).by(1)
      end

      it "assigns a newly created adventure as @adventure" do
        post :create, {:adventure => valid_attributes.except(:user_id), :user_id => @user.id}
        assigns(:adventure).should be_a(Adventure)
        assigns(:adventure).should be_persisted
      end

      it "redirects to the created adventure" do
        post :create, {:adventure => valid_attributes.except(:user_id), :user_id => @user.id}
        response.should redirect_to(Adventure.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved adventure as @adventure" do
        # Trigger the behavior that occurs when invalid params are submitted
        Adventure.any_instance.stub(:save).and_return(false)
        post :create, {:adventure => { "from" => "invalid value" }}, valid_session
        assigns(:adventure).should be_a_new(Adventure)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Adventure.any_instance.stub(:save).and_return(false)
        post :create, {:adventure => { "from" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested adventure" do
        adventure = Adventure.create! valid_attributes
        # Assuming there are no other adventures in the database, this
        # specifies that the Adventure created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Adventure.any_instance.should_receive(:update_attributes).with({ "from" => "MyString" })
        put :update, {:id => adventure.to_param, :adventure => { "from" => "MyString" }, :user_id => @user.id}, valid_session
      end

      it "assigns the requested adventure as @adventure" do
        adventure = Adventure.create! valid_attributes
       put :update, {:id => adventure.to_param, :adventure => valid_attributes, :user_id => @user.id}
        assigns(:adventure).should eq(adventure)
      end

      it "redirects to the adventure" do
        adventure = Adventure.create! valid_attributes
        put :update, {:id => adventure.to_param, :adventure => valid_attributes, :user_id => @user.id}, valid_session
        response.should redirect_to(adventure)
      end
    end

    describe "with invalid params" do
      it "assigns the adventure as @adventure" do
        adventure = Adventure.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Adventure.any_instance.stub(:save).and_return(false)
        put :update, {:id => adventure.to_param, :adventure => { "from" => "invalid value" }, :user_id => @user.id}, valid_session
        assigns(:adventure).should eq(adventure)
      end

      it "re-renders the 'edit' template" do
        adventure = Adventure.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Adventure.any_instance.stub(:save).and_return(false)
        put :update, {:id => adventure.to_param, :adventure => { "from" => "invalid value" }, :user_id => @user.id}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested adventure" do
      adventure = Adventure.create! valid_attributes
      expect {
        delete :destroy, {:id => adventure.to_param}, valid_session
      }.to change(Adventure, :count).by(-1)
    end

    it "redirects to the adventures list" do
      adventure = Adventure.create! valid_attributes
      delete :destroy, {:id => adventure.to_param}, valid_session
      response.should redirect_to(adventures_url)
    end
  end

end
