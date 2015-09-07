class Product < ActiveRecord::Base

  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :freebies, class_name: "Freebie", dependent: :destroy

  validates :prod_name, presence: true
  validates :prod_price, presence: true, inclusion: { in: 0..9999.9 }
  validates :prod_amount, inclusion: { in: 0..9999 }
  validates :prod_img, presence: true
  validates :prod_desc, length: { maximum: 500 }

  def valid_freebies
    vf = []
    freebies.each do |f|
      if Product.find(f.freebie_id).prod_amount > 0
        vf << f
      end
    end
    vf
  end
end
