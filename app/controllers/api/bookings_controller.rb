module Api
  class BookingsController < ApiController
    before_action :set_booking, only: [:show, :update, :destroy]
    def index
      authorize Booking
      render json: Booking.all
    end

    def show 
      authorize @booking
      render json: @booking
    end

    def create
      booking = Booking.new(booking_params)
      if booking.save
        render json: booking
      else
        render json: { message: 'Booking not saved' }, 
                       status: :unprocessable_entity
      end
    end

    def destroy
      @booking.destroy
        render json: { message: 'Booking deleted' },
                       status: :ok
    end

    def update
      if @booking.update_attributes(booking_params)
        render json: { message: 'Updated Booking'} , 
                       status: :ok
      else
        render json: { message: 'Booking not updated'} , 
                       status: :unprocessable_entity
      end
    end

    private
    def booking_params
      params.permit(:start_date,:end_date,:paid_price,:user_id,:room_id)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end

  end
end
