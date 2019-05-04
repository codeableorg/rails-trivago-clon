class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :cover

  validates :name, presence: true
  validates :amount_of_beds, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validates :hotel_id, presence:true
end
