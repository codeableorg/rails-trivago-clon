class AdminMailer < ApplicationMailer
  default from: 'gotosor@trivago.com'

  def notify_admin #it will notifiy to our admins when new user is created
    @admin = params[:user]
    mail(to: @admin.email, subject: 'New user created!')
  end
end
