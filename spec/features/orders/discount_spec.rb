require "rails_helper"

RSpec.describe "as a user" do
  it "can add discount to merchant items" do
    @merchant = create(:random_merchant)
    @discount_1 = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
    user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    item_1 = Item.create(name: "Awaken, My Love! - Childish Gambino", description: "PbR&B", price: 10, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/54839923_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20, merchant: @merchant)

    i = 0
    loop do 
      visit "/items/#{item_1.id}"
      click_on "Add To Cart"
      i += 1
      if i == 10
        break 
      end
    end

    visit "/cart"

    click_on "Checkout"

    fill_in :name, with: "John Bill"
    fill_in :address, with: "1491 Street St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "801231"

    click_on "Create Order"

    expect(page).to have_content("Total: $90")
  end
end

