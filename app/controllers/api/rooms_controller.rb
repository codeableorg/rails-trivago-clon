module Api
  class RoomsController < ApiController
    def index
      render json: Room.all
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
