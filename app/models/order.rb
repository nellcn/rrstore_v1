class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  validates :address, presence: true, length: { maximum: 200 }
end
