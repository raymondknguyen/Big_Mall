class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :percentage
      t.integer :min_items
      t.string :description

      t.timestamps
    end
  end
end
