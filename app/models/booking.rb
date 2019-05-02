class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def notify_users
    BookingMailer.with(user: user, booking: self).notify_users.deliver_later
  end  
end
