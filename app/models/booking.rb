class Booking < ApplicationRecord
  before_destroy :notify_users
  belongs_to :user
  belongs_to :room

  def notify_users
    BookingMailer.with(user: user, booking: self).notify_users.deliver_later
  end  
end
