module Api
  class Admin::BookingsController < ApplicationController
    def index
      render json: Booking.all
    end

    def show
      render json: Booking.find(params[:id])
    end

    def create
      booking = Booking.new(booking_params)
      if booking.save
        render json: booking
      else
        render json: { status: 'ERROR', 
                      message: 'Booking not saved' }, 
                      status: status: :unprocessable_entity
    end

    def destroy
      booking = Booking.find(params[:id])
      booking.destroy
        render json: { status: 'SUCCESS',
                      message: 'Booking deleted', },
                      status: :ok
    end

    def update
      booking = booking.find(params[:id])
      if booking.update_attributes(booking_params)
        render json: { status: 'SUCCESS',
                      message: 'Updated Booking',} , 
                      status: :ok
      else
        render json: { status: 'ERROR',
                      message: 'Booking not updated',} , 
                      status: :unprocessable_entity
      end
    end

    private
    def booking_params
      params.permit(:start_date,:end_date,:paid_price,:user_id,:room_id)
    end
  end
end
