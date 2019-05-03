class Booking < ApplicationRecord
  before_destroy :notify_users
  after_create :send_confirmation, :notify_booking
  belongs_to :user
  belongs_to :room

  def notify_users
    BookingMailer.with(user: user, booking: self).notify_users.deliver_later
  end  

  def send_confirmation
    BookingMailer.with(user: user, booking: self).booking_confirmation.deliver_later
  end

  def notify_booking
    BookingMailer.with(user: user, booking: self, hotel: self.room.hotel).booking_notification.deliver_later
  end
end