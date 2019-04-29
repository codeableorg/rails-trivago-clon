class Room < ApplicationRecord
  belongs_to :hotel
  has_one :promotion, as: :promotionable
end
