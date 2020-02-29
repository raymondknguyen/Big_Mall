class Discount <ApplicationRecord
  validates_presence_of :name, 
                        :percentage, 
                        :min_items, 
                        :description
  belongs_to :merchant
end