class Promotion < ApplicationRecord
  belongs_to :promotionable, polymorphic: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :discount_type, presence: true
  validates :discount_amount, presence: true
end
