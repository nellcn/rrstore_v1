class ChangePaytimeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payed_at, :datetime
    add_column :orders, :delivered_at, :datetime
    add_column :orders, :received_at, :datetime

    remove_column :order_items, :payed_at, :datetime
    remove_column :order_items, :delivered_at, :datetime
    remove_column :order_items, :received_at, :datetime
  end
end
