class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.send_email_noticed.subject
  #
  def send_email_noticed
    @comment = params[:comment]

    mail(to: params[:comment], subject: "You have a new message")
  end
end
