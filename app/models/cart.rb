class Cart < ActiveRecord::Base

  include StoreHelper

  belongs_to :user
  belongs_to :product

  validates :amount, presence: true

  def  validate_qty
    if amount > product.prod_amount
      errors.add :base, "You order too many items!"
    end
  end

  def prod_name
    product.prod_name
  end

  def prod_price
    product.prod_price
  end

  def prod_img
    product.prod_img
  end

  def discount
    @discount = 1
    @discount_rules = product.discounts
    @discount_rules.each do |d|
      if self.amount >= d.prod_qty && d.discount < @discount
        @discount = d.discount
      end
    end
    @discount
  end

  def price
    if discount == 1 then
      prod_price
    else
      discount_price
    end
  end

  def discount_price
    round_to_two_decimal (prod_price * discount)
  end

  def total_pay_amount
    round_to_two_decimal (price * amount)
  end

  def freebies_in_cart
    @freebie_rules = product.valid_freebies
    @fs = []
    @freebie_rules.each do |f|
      fq = ( self.amount / f.prod_qty ).round * f.freebie_qty
      if fq > 0
        newf = FreebieInCart.new
        newf.set_fid (f.freebie_id)
        newf.set_fqty (fq)
        @fs << newf
      end
    end
    @fs
  end

end
