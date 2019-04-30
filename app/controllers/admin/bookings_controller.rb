class Admin::BookingsController < ApplicationController
  before_action :set_bookings, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def show
  end
  
  def edit
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save 
      redirect_to admin_bookings_path(booking), notice: 'Booking already created!'
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to admin_bookings_path(@booking), notice: 'Booking already updated!'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to admin_bookings_path, notice: "Booking already deleted!"
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:paid_price, :user_id, :room_id)
  end
end

