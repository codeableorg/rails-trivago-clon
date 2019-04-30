class Hotel < ApplicationRecord
  has_many :rooms, dependent: :delete_all
  has_many :promotions, as: :promotionable
  has_many :bookings, through: :rooms
  has_one_attached :cover
end
