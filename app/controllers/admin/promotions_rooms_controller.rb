class Admin::PromotionsRoomsController < ApplicationController

  def index
    @room = Room.find(params[:room_id])
    @promotions = @room.promotions
  end

  def new
    @room = Room.find(params[:room_id])
    @promotion = Promotion.new
  end

  def show 
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
  end

  def edit 
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
  end

  def create
    @room = Room.find(params[:room_id])
    @promotion = @room.promotions.new(promotion_params)
    if @promotion.save
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully created'
    else 
      render :new
    end
  end

  def update
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully updated'
    else 
      render :new
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
    @promotion.destroy
    redirect_to admin_room_promotions_path, notice: "Promotion already deleted!"
  end

  private

  def promotion_params
    params.require(:promotion).permit(:start_date, :end_date, :discount_type, :discount_amount)
  end
end