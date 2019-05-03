class BookingPolicy < ApplicationPolicy

  attr_reader :user, :booking

  def index?
    @user&.regular?
  end

  def create?
    @user&.regular?
  end

  def edit?
    (@user.present? && @user.admin?) || (@user.present? && @booking.user_id == @user.id)
  end

  def update?
    (@user.present? && @user.admin?) || (@user.present? && @booking.user_id == @user.id)
  end

  def destroy?
    @user.admin? || @booking.user.id == @user.id
  end

  def show?
    @user&.regular?
  end
end