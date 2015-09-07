class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :prod_id
      t.integer :prod_qty
      t.decimal :discount

      t.timestamps null: false
    end
  end
end
