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

  def create?
    @user&.admin?
  end
 
  def destroy?
    @user&.admin?
  end

  def update?
    @user&.admin?
  end
end