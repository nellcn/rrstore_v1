class RemoveProdIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :prod_id
  end
end
