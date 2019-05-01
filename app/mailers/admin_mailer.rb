class AdminMailer < ApplicationMailer

  def notify_admin #it will notifiy to our admins when new user is created
    @user = params[:user]
    @user_created = params[:user_created]
    mail(to: @user.email, subject: 'New user created!')
  end
end
