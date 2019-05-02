class Hotel < ApplicationRecord
  before_destroy :notify_users
  has_many :rooms, dependent: :delete_all
  has_many :promotions, as: :promotionable
  has_many :bookings, through: :rooms
  has_one_attached :cover

  def notify_users
    BookingMailer.with(user: user, booking: room_id).notify_users.deliver_later
  end
end
