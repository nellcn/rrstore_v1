class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :prod_qty
      t.decimal :discount
      t.decimal :sub_pay

      t.timestamps null: false
    end
  end
end
