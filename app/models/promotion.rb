class Promotion < ApplicationRecord
  belongs_to :promotionable, polymorphic: true

  def applicable?
    self.start_date <= Date.today && self.end_date >= Date.today
  end

end
