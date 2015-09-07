class CreateCarts < ActiveRecord::Migration
  def change
#    drop_table :carts, :cascade

    create_table :carts do |t|
      t.integer :cust_id
      t.integer :prod_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
