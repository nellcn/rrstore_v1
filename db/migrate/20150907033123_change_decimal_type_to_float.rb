class ChangeDecimalTypeToFloat < ActiveRecord::Migration
  def change
    change_column :products, :prod_price, :float
    change_column :discounts, :discount, :float
    change_column :orders, :total_pay, :float
    change_column :order_items, :discount, :float
    change_column :order_items, :sub_pay, :float
    change_column :order_items, :prod_price, :float
  end
end
