class Admin::RoomsController < ApplicationController
  before_action :set_rooms, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def show
  end
  
  def edit
  end

  def create
    @room = Room.create(set_rooms)
    @room = current_user.rooms.create(set_rooms)

    if @room.save 
      redirect_to rooms_path(@room), notice: 'Room already created!'
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to rooms_path(@room), notice: 'Room already updated!'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "Room already deleted!"
  end

  private

  def set_rooms
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :amount_of_beds, :price, :hotel_id, :address)
  end
end