class Admin::PromotionsHotelsController < ApplicationController

  def index
    @hotel = Hotel.find(params[:hotel_id])
    @promotions = @hotel.promotions
  end

  def new
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = Promotion.new
  end

  def show 
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = Promotion.find(params[:id])
  end

  def edit 
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = Promotion.find(params[:id])
  end

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = @hotel.promotions.new(promotion_params)
    if @promotion.save
      redirect_to admin_hotel_promotions_path(@hotel), notice: 'Promotion was successfully created'
    else 
      render :new
    end
  end

  def update
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to admin_hotel_promotions_path(@hotel), notice: 'Promotion was successfully updated'
    else 
      render :new
    end
  end

  def destroy
    @hotel = Hotel.find(params[:hotel_id])
    @promotion = Promotion.find(params[:id])
    @promotion.destroy
    redirect_to admin_hotel_promotions_path, notice: "Promotion already deleted!"
  end

  private

  def promotion_params
    params.require(:promotion).permit(:start_date, :end_date, :discount_type, :discount_amount)
  end
end