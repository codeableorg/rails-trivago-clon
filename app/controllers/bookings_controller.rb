class BookingsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @bookings = Booking.where(name: params[:search])
    else
      @bookings = Booking.all
    end
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create 
    @booking = Booking.new(booking_params)
    if @booking.save(booking_params)
      redirect_to admin_booking_path(@booking), notice: "The booking was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to admin_booking_path(@booking), notice: "The booking was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to admin_bookings_path, notice: "The booking was successfully deleted"
  end

  # def rooms
  # @booking = Booking.find(params[:id])
  #   if params[:min_price].present? && params[:max_price].present?
  #     @rooms = @booking.rooms.where(
  #       'price <= ? AND price >= ?',
  #       params[:max_price], params[:min_price]
  #     )
  #   else
  #     @rooms = @booking.rooms
  #   end
  # end

  private 

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :paid_price, :user_id, :room_id)
  end

end
