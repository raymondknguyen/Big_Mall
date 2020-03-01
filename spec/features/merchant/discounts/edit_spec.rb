require 'rails_helper'

RSpec.describe "As a Merchant" do
  describe "When I visit my discount Index Page" do
    describe "and click on edit discount" do
      before :each do
        @merchant = create(:random_merchant)
        @merchant_employee = create(:merchant_user, merchant: @merchant)
        @discount_1 = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
      
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
      end
      
      it 'I can see the prepopulated fields of that item and update it' do

        visit "/merchant/discounts"

        within "#discount-#{@discount_1.id}" do
         click_on "Edit"
        end

        expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

        fill_in :name, with: "name change"
        fill_in :percentage, with: 30
        fill_in :min_items, with: 50
        fill_in :description, with: "description change"

        click_on "Update Discount"

        expect(current_path).to eq("/merchant/discounts")
   
        expect(page).to_not have_content("10% Discount!")
        expect(page).to_not have_content("Discount %: 10")
        expect(page).to_not have_content("If items exceeds: 10")
        expect(page).to_not have_content("If you buy 10 items or more you get 10% off each items from this merchant")

        expect(page).to have_content("name change")
        expect(page).to have_content("Discount %: 30")
        expect(page).to have_content("If items exceeds: 50")
        expect(page).to have_content("description change")
      end 
    end
  end
end