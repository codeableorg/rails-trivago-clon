class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authorization_method

  def index 
    if params[:search].present?
      @bookings = Booking.where(name: params[:search])
    else
      @bookings = Booking.where(user: current_user)
    end
  end

  def show
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save(booking_params)
      redirect_to booking_path(@booking), notice: "The booking was successfully created"
    else
      render :new
    end
    authorize @booking
  end

  def edit
    authorize @booking
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "The booking was successfully updated"
    else
      render :edit
    end
    authorize @booking
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "The booking was successfully deleted"
    authorize @booking
  end

  private 

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :paid_price, :user_id, :room_id)
  end

  def authorization_method
    authorize Booking
  end

end
