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

end
