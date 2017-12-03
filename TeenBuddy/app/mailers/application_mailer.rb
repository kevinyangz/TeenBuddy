class ApplicationMailer < ActionMailer::Base
  config.uses_emails = false
  default from: 'from@example.com'
  layout 'mailer'
end
