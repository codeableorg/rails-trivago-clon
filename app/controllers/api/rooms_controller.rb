class Api::RoomsController < ApiController
  before_action :authorization_method

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
        
        current_user.bookings.create( 
          start_date: params[:min_date], 
          end_date: params[:max_date], 
          paid_price: paid_price, 
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

