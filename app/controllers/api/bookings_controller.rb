module Api
  class BookingsController < ApiController
    def index
      render json: Booking.all
      authorize @bookings
    end

    def show
      render json: Booking.find(params[:id])
      # authorize @booking
    end

    def create
      booking = Booking.new(booking_params)
      if booking.save
        render json: booking
      else
        render json: { message: 'Booking not saved' }, 
                       status: :unprocessable_entity
      end
      # authorize @booking
    end

    def destroy
      booking = Booking.find(params[:id])
      booking.destroy
        render json: { message: 'Booking deleted' },
                       status: :ok
    # authorize @booking
    end

    def update
      booking = Booking.find(params[:id])
      if booking.update_attributes(booking_params)
        render json: { message: 'Updated Booking'} , 
                       status: :ok
      else
        render json: { message: 'Booking not updated'} , 
                       status: :unprocessable_entity
      end
      # authorize @booking
    end

    private
    def booking_params
      params.permit(:start_date,:end_date,:paid_price,:user_id,:room_id)
    end
  end
end
