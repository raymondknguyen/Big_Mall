class Discount <ApplicationRecord
  validates_presence_of :name, 
                        :percentage, 
                        :min_items, 
                        :description
  validates_numericality_of :percentage, greater_than: 0, less_than_or_equal_to: 100
  validates_numericality_of :min_items, greater_than: 0
  belongs_to :merchant

  def items_with_discount
    Discount.joins(merchant: :items).where('items.id = ?', cart.contents.keys)
  end
end