class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :prod_id
      t.string :prod_name
      t.decimal :prod_price
      t.integer :prod_amount
      t.text :prod_desc

      t.timestamps null: false
    end
  end
end
