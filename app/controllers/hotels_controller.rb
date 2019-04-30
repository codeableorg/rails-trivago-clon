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

  def new
  end

  def edit
  end

  def rooms
    @hotel = Hotel.find(params[:id])
    if params[:min_price].present? && params[:max_price].present?
      @rooms = @hotel.rooms.where(
        'price <= ? AND price >= ?',
        params[:max_price], params[:min_price]
      )
    else
      @rooms = @hotel.rooms
    end
  end

end
