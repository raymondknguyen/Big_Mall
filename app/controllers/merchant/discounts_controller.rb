class Merchant::DiscountsController < ApplicationController

  def index
    @discounts = Merchant.find(current_user.merchant.id).discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @discount = merchant.discounts.create(discount_params)
    if @discount.save 
      redirect_to "/merchant/discounts"
    end
  end

  def edit 
    @discount_id = params[:id]
  end

  def update
    discount = Discount.find(params[:id])
    discount.update(discount_params)
    redirect_to "/merchant/discounts"
  end


  private

  def discount_params
    params.permit(:name, :percentage, :min_items, :description)
  end
end