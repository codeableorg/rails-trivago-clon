class Booking < ApplicationRecord
  before_destroy :notify_users, :booking_deleted
  after_create :send_confirmation, :notify_booking, :reservation_tomorrow
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

  def booking_deleted
    BookingMailer.with(user: user, booking: self).user_booking_deleted.deliver_later
  end

  def reservation_tomorrow
    SendReminderNotificationJob.set(wait_until: ((self.start_date - 1.day)- DateTime.now).to_s).perform_later(self)
  end

end
