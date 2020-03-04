require "rails_helper"

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :min_items }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end

  describe "instance methods" do
    before :each do
    @merchant = create(:random_merchant)
    @discount = @merchant.discounts.create(name: "10% Discount!", percentage: 10, min_items: 10, description: "If you buy 10 items or more you get 10% off each items from this merchant")
    @item = Item.create(name: "Awaken, My Love! - Childish Gambino", description: "PbR&B", price: 100, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/54839923_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20, merchant: @merchant)
    end
    it 'can check for the most qualified discount for item' do
      expect(@item.check_for_discount(10)).to eq(@discount)
    end
  end
end