class Hotel < ApplicationRecord
  has_many :rooms
  has_many :promotions, as: :promotionable
end
