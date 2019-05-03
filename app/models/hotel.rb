class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :promotions, as: :promotionable, dependent: :destroy
  has_many :bookings, through: :rooms
  has_one_attached :cover

  def notify_users
    BookingMailer.with(user: user, booking: room_id).notify_users.deliver_later
  end
end
