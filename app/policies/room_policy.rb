class RoomPolicy < ApplicationPolicy

  attr_reader :user, :room

  def initialize(user, room)
    @user = user
    @room = room
  end

  def index?
    return true if user.admin?
  end
 
  def create?
    return true if user.admin?
  end

  def edit?
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