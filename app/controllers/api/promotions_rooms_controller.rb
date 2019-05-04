class Api::PromotionsRoomsController < ApiController
  before_action :authorization_method
  before_action :set_promotion, only: [:show, :update, :destroy]
  
  def index
    render json: Room.find(params[:room_id]).promotions
  end
  
  def show
    render json: @promotion
  end
  
  def create
    room = Room.find(params[:room_id])
    promotion = room.promotions.new(promotion_params)
    if promotion.save
      render json: promotion, status: :created
    else 
      render json: { errors: @promotion.errors}
    end
  end
  
  def update
    if @promotion.update(promotion_params)
      render json: @promotion, status: :ok
    else 
      render json: { errors: @promotion.errors}
    end
  end
  
  def destroy
    @promotion.destroy
    render json: {},status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
  
  private    
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
  
  def promotion_params
    params.permit(:start_date, :end_date, :discount_type, :discount_amount)
  end

  def authorization_method
    authorize [:admin, :promotion]
  end
  
end