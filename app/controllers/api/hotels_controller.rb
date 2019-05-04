class Api::HotelsController < ApiController
  before_action :authorization_method
  def index
    render json: Hotel.all
  end

  def show
    render json: Hotel.find(params[:id])
  end

  def create
    hotel = Hotel.new(hotel_params)
    if hotel.save
      render json: hotel
    else
      render json: { message: 'Hotel not saved' }, 
                      status: :unprocessable_entity
    end
  end

  def destroy
    hotel = Hotel.find(params[:id])
    hotel.destroy
      render json: { message: 'Hotel deleted'},
                      status: :ok
  end

  def update
    hotel = Hotel.find(params[:id])
    if hotel.update_attributes(hotel_params)
      render json: { message: 'Updated hotel'} , 
                      status: :ok
    else
      render json: { message: 'Hotel not updated'} , 
                      status: :unprocessable_entity
    end
  end

  private
  def hotel_params
    params.permit(:name,:email,:city,:country,:address)
  end

  def authorization_method
    authorize Hotel
  end
end
