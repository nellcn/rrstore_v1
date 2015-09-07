module StoreHelper

  def base_currency
    "$" # USD
  end
  
  # calculate total cost for products in cart
  def get_cart_total_cost
    @total = 0
    current_user.carts.each do |c|
      @total = @total + c.total_pay_amount
    end
    round_to_two_decimal (@total)
  end

  def clear_cart
    current_user.carts.each do |c|
      c.delete
    end
  end

  def round_to_two_decimal (d)
    (d * 100).round/100.0
  end

end
