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
    if params[:search].present?
      @rooms = @hotel.rooms.where(name: params[:search])

      # Course.where('min_age <= :age AND max_age >= :age', age: 18)
    else
      @rooms = @hotel.rooms
    end
  end

end
