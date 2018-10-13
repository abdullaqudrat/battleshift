class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
   default from: "no-reply@battleshiftgames.com"
end
