class Admin::HotelsController < ApplicationController
  before_action :set_hotels, only: [:show, :edit, :update, :destroy]

  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
  end

  def show
  end
  
  def edit
  end

  def create
    @hotel = Hotel.create(set_hotels)
    @hotel = current_user.hotels.create(set_hotels)

    if @hotel.save 
      redirect_to hotels_path(@hotel), notice: 'Hotel already created!'
    else
      render :new
    end
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to hotels_path(@hotel), notice: 'Hotel already updated!'
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to hotels_path, notice: "Hotel already deleted!"
  end

  private

  def set_hotels
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :email, :city, :country, :address)
  end
end