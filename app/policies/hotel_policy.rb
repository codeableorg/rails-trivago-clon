class HotelPolicy < ApplicationPolicy

  attr_reader :user, :hotel

  def index?
    true
  end

  def show?
    true
  end

  def rooms?
    true
  end
 
end