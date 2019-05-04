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

  def booking_notification
    @user = params[:user]
    @booking = params[:booking]
    @hotel = params[:hotel]
    mail(to: @hotel.email, subject: 'A room has been booked')
  end

  def user_booking_deleted
    @user = params[:user]
    @booking = params[:booking]
    @hotel = params[:hotel]
    mail(to: @user.email, subject: "Unfortunately your booking has been deleted" )
  end

  def day_before_booking
    @user = params[:user]
    @booking = params[:booking]
    @hotel = params[:hotel]
    mail(to: @user.email, subject: "Your reservation is for tomorrow!" )
  end

end
