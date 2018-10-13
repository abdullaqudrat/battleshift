require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activate" do

      it "renders the headers" do
				user = create(:user)
				mail = UserMailer.activate(user)
        expect(mail.subject).to eq("Confirm Your Account")
        expect(mail.to).to eq(["jbartlet@example.com"])
        expect(mail.from).to eq(["no-reply@battleshiftgames.com"])
      end

      it "renders the body" do
				user = create(:user)
				mail = UserMailer.activate(user)
        expect(mail.body.encoded).to have_content("Click here to activate your account")
        expect(mail.body.encoded).to have_content("API Key: ")
       end
     end
end

