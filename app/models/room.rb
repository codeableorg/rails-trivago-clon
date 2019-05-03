class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable
  has_many :bookings, dependent: :destroy
  has_one_attached :cover
end
