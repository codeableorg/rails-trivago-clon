class RoomsController < ApplicationController
  before_action :authorization_method, except: [:book]

  def index

    @rooms = Room.all

    if params[:search].present?
      @rooms = @rooms.where(name: params[:search])
    end

    if params[:min_price].present? && params[:max_price].present?
      @rooms = @rooms.where(
        'price <= ? AND price >= ?',
        params[:max_price], params[:min_price]
      )
    end

    if params[:min_beds].present? && params[:max_beds].present?
      @rooms = @rooms.where(
        'amount_of_beds <= ? AND amount_of_beds >= ?',
        params[:max_beds], 
        params[:min_beds]
      )
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
      @hotel = @room.hotel
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
        
        paid_price = @room.price
        total_discount = get_discount(@room)
        paid_price -= total_discount

        paid_price = 0 if paid_price < 0
        
        new_booking = current_user.bookings.new( 
          start_date: params[:min_date], 
          end_date: params[:max_date], 
          paid_price: paid_price, 
          room_id: @room.id 
        )    
        authorize new_booking, policy_class: RoomPolicy
        new_booking.save
      end
      redirect_to action: 'show'
    end  
  end

  def get_discount(room)
      
    paid_price = room.price
    hotel = room.hotel
    discount = 0

    hotel_discount = 0
    hotel.promotions.each do |promotion|
      if promotion.applicable?
        if promotion.discount_type == 'percentage'
          discount = ((promotion.discount_amount.to_f/100)*paid_price).to_i
        elsif promotion.discount_type == 'fixed'
          discount = promotion.discount_amount
        end

        hotel_discount = discount if discount > hotel_discount
      end
    end

    room_discount = 0
    room.promotions.each do |promotion|
      if promotion.applicable?
        if promotion.discount_type == 'percentage'
          discount = ((promotion.discount_amount.to_f/100)*paid_price).to_i
        elsif promotion.discount_type == 'fixed'
          discount = promotion.discount_amount
        end

        room_discount = discount if discount > room_discount
      end
    end

    hotel_discount + room_discount
  end

  def authorization_method
    authorize Room
  end

end
