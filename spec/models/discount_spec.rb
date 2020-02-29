require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :number_of_items }
    it ( should validate_presence_of :description )
  end
end