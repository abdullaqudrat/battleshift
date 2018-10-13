class UserMailer < ApplicationMailer
	def activate(user)
		@user = user
    mail(to: user.email, subject: "Confirm Your Account")
  end
end
