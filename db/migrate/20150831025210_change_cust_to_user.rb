class ChangeCustToUser < ActiveRecord::Migration
  def change
    rename_column :carts, :cust_id, :user_id
  end
end
