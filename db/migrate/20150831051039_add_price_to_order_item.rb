class AddPriceToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :prod_price, :decimal
  end
end
