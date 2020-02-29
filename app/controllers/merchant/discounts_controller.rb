class Merchant::DiscountsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @discount = merchant.discounts.create(discount_params)
  end

  private

  def discount_params
    params.permit(:name, :percentage, :min_items, :description)
  end
end