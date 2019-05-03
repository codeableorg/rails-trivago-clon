class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable
  has_many :bookings
  has_one_attached :cover

  validates :name, presence: true
  validates :amount_of_beds, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validates :hotel_id, presence:true
end
