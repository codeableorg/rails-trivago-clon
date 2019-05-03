module Api
  class RoomsController < ApiController
    def index
      
      rooms = Room.all
      if params[:min_price].present? && params[:max_price].present?
        rooms = rooms.where(
          'price <= ? AND price >= ?',
          params[:max_price], 
          params[:min_price]
        )
      end

      if params[:min_beds].present? && params[:max_beds].present?
        rooms = rooms.where(
          'amount_of_beds <= ? AND amount_of_beds >= ?',
          params[:max_beds], 
          params[:min_beds]
        )
      end

      render json: rooms

    end

    def book
      if params[:min_date].present? && params[:max_date].present?

        @room = Room.find(params[:id])
        @bookings = @room.bookings 
  
        @conflict_ids = @bookings.where(
          [
            '(start_date <= :min_date AND end_date >= :max_date)',
            '(start_date >= :min_date AND start_date <= :max_date)',
            '(end_date >= :min_date AND end_date <= :max_date)'
          ].join(' OR'),
          {
            min_date: params[:min_date],
            max_date: params[:max_date]
          }  
        ).ids
        
        if @conflict_ids.none?
          current_user.bookings.create( 
            start_date: params[:min_date], 
            end_date: params[:max_date], 
            paid_price: @room.price, 
            room_id: @room.id 
          )    
          render json: current_user.bookings
        else
          render json: "booking conflicts"
        end
      else
        render json: "not enough params" 
      end  
    end


    def show
      render json: Room.find(params[:id])
    end

    def create
      room = Room.new(room_params)
      if room.save
        render json: room
      else
        render json: { message: 'Room not saved' }, 
                       status: :unprocessable_entity
      end
    end

    def destroy
      room = Room.find(params[:id])
      room.destroy
        render json: { message: 'Room deleted'},
                       status: :ok
    end

    def update
      room = Room.find(params[:id])
      if room.update_attributes(room_params)
        render json: { message: 'Updated Room'} , 
                       status: :ok
      else
        render json: { message: 'Room not updated'} , 
                       status: :unprocessable_entity
      end
    end



    private
    def room_params
      params.permit(:name,:amount_of_beds,:price,:hotel_id)
    end
  end
end
