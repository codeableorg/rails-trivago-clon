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
