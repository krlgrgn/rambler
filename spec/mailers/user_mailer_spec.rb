require "spec_helper"

describe UserMailer do
  before :each do
    @user = FactoryGirl.create(:user, email: "to@example.org")
  end
  describe "reset_password" do
    let(:mail) { UserMailer.reset_password(@user, "askdjahsdkjahuw382923h") }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("UserMailer#reset_password\r\nClick the link to reset your password:\r\n<a href=\"http://localhost:8080/password_resets/askdjahsdkjahuw382923h/edit\">Reset Password</a>\r\n")
    end
  end

end
