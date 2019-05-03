class HotelsController < ApplicationController
  def index
    if params[:search].present?
      @hotels = Hotel.where(name: params[:search])
    else
      @hotels = Hotel.all
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def rooms
    @hotel = Hotel.find(params[:id])
    @rooms = @hotel.rooms

    if params[:min_price].present? && params[:max_price].present?
      @rooms = @rooms.where(
        'price <= ? AND price >= ?',
        params[:max_price], params[:min_price]
      )
    end

    if params[:min_beds].present? && params[:max_beds].present?
      @rooms = @rooms.where(
        'amount_of_beds <= ? AND amount_of_beds >= ?',
        params[:max_beds], 
        params[:min_beds]
      )
    end

  end

end
