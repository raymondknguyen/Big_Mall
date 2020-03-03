require "rails_helper"

RSpec.describe "as a user" do
  before :each do
    @merchant = create(:random_merchant)
    @discount_1 = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
    @user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it "can add discount to merchant items" do
    item_1 = Item.create(name: "Awaken, My Love! - Childish Gambino", description: "PbR&B", price: 100, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/54839923_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20, merchant: @merchant)
    
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

    within "#cart-item-#{item_1.id}" do
      expect(page).to have_content("$90.00")
    end
    
    click_on "Checkout"

    fill_in :name, with: "John Bill"
    fill_in :address, with: "1491 Street St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "801231"

    click_on "Create Order"

    new_order = Order.last

    expect(page).to have_content("Order##{new_order.id}")
    expect(page).to have_content("Grand total: $900.00")

  end

  it "can only process one discount" do
    item_1 = Item.create(name: "Awaken, My Love! - Childish Gambino", description: "PbR&B", price: 100, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/54839923_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20, merchant: @merchant)

    discount_2 = @merchant.discounts.create(name: "5% Discount!", percentage: 5, min_items: 5, description: "If you buy 5 items or more you get 5% off each items from this merchant")
    discount_3 = @merchant.discounts.create(name: "20% Discount!", percentage: 20, min_items: 20, description: "If you buy 5 items or more you get 5% off each items from this merchant")

    i = 0
    loop do 
      visit "/items/#{item_1.id}"
      click_on "Add To Cart"
      i += 1
      if i == 20
        break 
      end
    end
    
    visit "/cart"

    within "#cart-item-#{item_1.id}" do
      expect(page).to have_content("$80.00")
      expect(page).to have_content("$1,600.00")
    end
    
    click_on "Checkout"
    
    fill_in :name, with: "John Bill"
    fill_in :address, with: "1491 Street St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "801231"

    click_on "Create Order"

    new_order = Order.last

    expect(page).to have_content("Order##{new_order.id}")
    expect(page).to have_content("Grand total: $1,600.00")
  end
end

