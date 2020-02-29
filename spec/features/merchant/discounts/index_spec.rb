require "rails_helper"

RSpec.describe "As a merchant employee" do
  before :each do
    @merchant = create(:random_merchant)
    @merchant_employee = create(:merchant_user, merchant: @merchant)
    @discount_1 = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
    @discount_2 = @merchant.discounts.create(name: "20% Discount!", percentage: 20, min_items: 20, description: "If you buy 20 items or more you get 10% off each items from this merchant")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  it "can see all discount of this merchant" do
    visit "/merchant/discounts"
    
    within "#discount-#{@discount_1.id}" do
      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content("Discount %: 10")
      expect(page).to have_content("If items exceeds: 10")
      expect(page).to have_content("If you buy 10 items or more you get 10% off each items from this merchant")
    end

    within "#discount-#{@discount_2.id}" do
      expect(page).to have_content(@discount_2.name)
      expect(page).to have_content("Discount %: 20")
      expect(page).to have_content("If items exceeds: 20")
      expect(page).to have_content("If you buy 20 items or more you get 10% off each items from this merchant")
    end
  end
end