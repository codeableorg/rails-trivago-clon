class Promotion < ApplicationRecord
  belongs_to :promotionable, polymorphic: true
end
