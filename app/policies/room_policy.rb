class RoomPolicy < ApplicationPolicy

  attr_reader :user, :room

  def index?
    true
  end

  def show?
    true
  end

  def book?
    if @user&.regular?
      @record.user_id == @user.id
    end 
  end
 
end