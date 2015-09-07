class CreateFreebies < ActiveRecord::Migration
  def change
    create_table :freebies do |t|
      t.integer :prod_id
      t.integer :prod_qty
      t.integer :freebie_id
      t.integer :freebie_qty

      t.timestamps null: false
    end
  end
end
