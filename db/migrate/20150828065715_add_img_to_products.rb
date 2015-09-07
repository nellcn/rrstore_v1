class AddImgToProducts < ActiveRecord::Migration
  def change
    add_column :products, :prod_img, :string
  end
end
