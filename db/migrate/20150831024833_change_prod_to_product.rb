class ChangeProdToProduct < ActiveRecord::Migration
  def change
    rename_column :carts, :prod_id, :product_id
    rename_column :discounts, :prod_id, :product_id
    rename_column :freebies, :prod_id, :product_id
  end
end
