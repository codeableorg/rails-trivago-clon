class SendReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform(booking)
    BookingMailer.with(user: booking.user, booking: booking).day_before_booking.deliver_later
  end
end
