class RoomsController < ApplicationController

  def show    
    @room = Room.find(params[:id])
    @error = ''

    if params[:min_date].present? && params[:max_date].present?

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

    else
      @bookings = @room.bookings
    end
    
  end
end
