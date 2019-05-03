class Hotel < ApplicationRecord
  before_destroy :notify_users
  has_many :rooms, dependent: :delete_all
  has_many :promotions, as: :promotionable
  has_many :bookings, through: :rooms
  has_one_attached :cover

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :city, presence: true
  validates :country, presence: true
  validates :address, presence: true

  def notify_users
    BookingMailer.with(user: user, booking: room_id).notify_users.deliver_later
  end
end
