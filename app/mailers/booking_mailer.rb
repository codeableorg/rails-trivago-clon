class BookingMailer < ApplicationMailer

  def notify_users #it will notifiy to our users when a hotel is delete with all bookings related
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Hotel deleted from database')
  end

  def booking_confirmation
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Booking confirmed!')
  end

  
end
