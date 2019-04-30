module Api
  class Admin::HotelsController < ApplicationController
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
        render json: { status: 'ERROR', 
                      message: 'Hotel not saved' }, 
                      status: status: :unprocessable_entity
    end

    def destroy
      hotel = Hotel.find(params[:id])
      hotel.destroy
        render json: { status: 'SUCCESS',
                      message: 'Hotel deleted', },
                      status: :ok
    end

    def update
      hotel = Hotel.find(params[:id])
      if hotel.update_attributes(hotel_params)
        render json: { status: 'SUCCESS',
                      message: 'Updated hotel',} , 
                      status: :ok
      else
        render json: { status: 'ERROR',
                      message: 'Hotel not updated',} , 
                      status: :unprocessable_entity
      end
    end

    private
    def hotel_params
      params.permit(:name,:email,:city,:country,:address)
    end
  end
end
