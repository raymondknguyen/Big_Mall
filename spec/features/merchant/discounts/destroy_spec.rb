require 'rails_helper'

RSpec.describe "As a merchant employee" do
  before :each do
     @merchant = create(:random_merchant)
      @merchant_employee = create(:merchant_user, merchant: @merchant)
      @discount_1 = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
    
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  it "can delete a discount" do
  
    visit "/merchant/discounts"

    within "#discount-#{@discount_1.id}" do
      click_on "Delete"
    end

    expect(current_path).to eq("/merchant/discounts")
   
    expect(page).to_not have_content("10% Discount!")
    expect(page).to_not have_content("Discount %: 10")
    expect(page).to_not have_content("If items exceeds: 10")
    expect(page).to_not have_content("If you buy 10 items or more you get 10% off each items from this merchant")
  end
end