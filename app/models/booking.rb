class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :hotel
end
