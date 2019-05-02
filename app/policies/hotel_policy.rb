class HotelPolicy < ApplicationPolicy

  attr_reader :user, :hotel

  def initialize(user, hotel)
    @user = user
    @hotel = hotel
  end

  def index?
    true
  end

  def edit?
    return true if user.admin?
  end
 
  def create? 
    return true if user.admin?
  end
 
  def update?
    return true if user.admin?
  end
 
  def destroy?
    return true if user.admin?
  end
 
  private
 
    def article
      record
    end
end