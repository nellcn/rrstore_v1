class NewOrder

  attr_accessor :order
  attr_accessor :order_items

  def initialize
    @order = Order.new
    @order_items = []
  end

  def set_order (order)
    @order = order
  end

  def add_order_item(order_item)
    @order_items << order_item
  end


end
