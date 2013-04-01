require 'spec_helper'

describe "Password Resets" do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  describe "GET /password_resets/new" do
    it "responds with a 200 status" do
      get new_password_reset_path
      response.status.should be(200)
    end
  end
  describe "GET /password_resets/:id/edit" do
    it "responds with a 200 status" do
      token = ActiveSupport::MessageVerifier.new(
        Rails.configuration.secret_token).generate(
          [@user.id,1.day.from_now,@user.password_digest])
      get edit_password_reset_path(token)
      response.status.should be(200)
    end
  end
  describe "POST /password_resets" do
    it "responds with a 302 status" do
      post password_resets_path, { :password_reset => { :email => @user.email } }
      # Whether the email address is valid or not the response should
      # be a 302
      response.status.should be(302)
    end
  end
  describe "PUT /password_reset/:id" do
    before :each do
      @token = ActiveSupport::MessageVerifier.new(
        Rails.configuration.secret_token).generate(
          [@user.id,1.day.from_now,@user.password_digest])
    end
    context "with valid params" do
      it "responds with a 200 status" do
        put password_reset_path(@token), {
          :id => @token, :user => { "state" => "new_state" }}
        response.status.should be(200)
      end
    end
    context "with invalid params" do
      it "responds with a 200 status when the passwords dont match" do
        User.any_instance.should_receive(:update_attributes).with({ "state" => "new_state" }).and_return(nil)
        put password_reset_path(@token), {
          :id => @token, :user => { "state" => "new_state" }}
        response.status.should be(200)
      end
      pending "Write request test where the find by reset token fails"
      #it "responds with a 200 status when the token is invalid" do
        #invalid_token = "invalid_token"
        #put password_reset_path(invalid_token), {
          #:id => invalid_token, :user => { "state" => "new_state" }}
        #response.status.should be(200)
    end
  end
end
