class Booking < ApplicationRecord
  before_destroy :notify_users
  after_create :send_confirmation
  belongs_to :user
  belongs_to :room

  def notify_users
    BookingMailer.with(user: user, booking: self).notify_users.deliver_later
  end  

  def send_confirmation
    BookingMailer.with(user: user, booking: self).booking_confirmation.deliver_later
  end

  # def notify_booking
  #   BookingMailer.with(user: admin, booking: self).booking_notification.deliver_later
  # end
end
  