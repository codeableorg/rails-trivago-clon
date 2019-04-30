class Hotel < ApplicationRecord
  has_many :rooms
  has_many :promotions, as: :promotionable
  has_many :bookings, through: :rooms
  has_one_attached :cover
end
