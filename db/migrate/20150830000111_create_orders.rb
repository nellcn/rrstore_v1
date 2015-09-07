class CreateOrders < ActiveRecord::Migration
  def change
#    drop_table :orders, :cascade
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :total_pay

      t.timestamps null: false
    end
  end
end
