class AddColumnsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :payed_at, :datetime
    add_column :order_items, :delivered_at, :datetime
    add_column :order_items, :received_at, :datetime 
  end
end
