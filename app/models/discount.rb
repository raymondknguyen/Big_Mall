class Discount <ApplicationRecord
  validates_presence_of :name, 
                        :percentage, 
                        :min_items, 
                        :description
  belongs_to :merchant

  def items_with_discount
    Discount.joins(merchant: :items).where('items.id = ?', cart.contents.keys)
  end
end