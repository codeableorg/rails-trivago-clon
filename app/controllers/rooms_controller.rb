class RoomsController < ApplicationController

  def index
    if params[:search].present?
      @rooms = Room.where(name: params[:search])
    else
      @rooms = Room.all
    end
  end

  def show    
    @room = Room.find(params[:id])
    @conflict_ids = []
    @bookings = @room.bookings 
    @error = ''
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
      end
      redirect_to action: 'show'
    end  
  end
end
