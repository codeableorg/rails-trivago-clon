class AdminMailer < ApplicationMailer

  def notify_admin #it will notifiy to our admins when new user is created
    @user = params[:user]
    mail(to: @user.email, subject: 'New user created!')
  end
end
