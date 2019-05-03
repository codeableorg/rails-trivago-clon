
class BookingPolicy < ApplicationPolicy

  attr_reader :user, :booking

  def initialize(user, booking)
    @user = user
    @booking = booking
  end

  def index?
    true
  end

  def create?
    user.present?
  end

  def edit?
    (user.present? && user.admin?) || (user.present? && @booking.user_id == user.id)
  end

  def update?
    (user.present? && user.admin?) || (user.present? && @booking.user_id == user.id)
  end

  def destroy?
    user.admin? || @booking.user.id == user.id
  end

  def show?
    user.admin?
  end

  private
 
    def booking
      record
    end
end