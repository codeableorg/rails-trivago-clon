class RoomPolicy < ApplicationPolicy

  attr_reader :user, :room

  def index?
    true
  end

  def show?
    true
  end

  def book?
    @user&.regular?
  end
 
  def create?
    @user&.admin?
  end

  def edit?
    @user&.admin?
  end
 
  def update?
    @user&.admin?
  end
 
  def destroy?
    @user&.admin?
  end
 
end