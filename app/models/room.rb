class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable
  has_many :bookings
end
