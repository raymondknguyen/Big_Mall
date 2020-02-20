class Admin::MerchantsController < ApplicationController
  
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.toggle!(:active?)
    if !merchant.active?
      merchant.items.update_all(active?: false)
      flash[:notice] = "#{merchant.name} has been deactivated."
    else
      merchant.items.update_all(active?: true)
      flash[:notice] = "#{merchant.name} has been activated."
    end
    redirect_to admin_merchants_path
  end
end

