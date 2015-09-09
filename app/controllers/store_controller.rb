class StoreController < ApplicationController

  before_filter :signed_in_store, 
    :only => [:show_orders, :show_order, :show_cart,
              :add_to_cart, :remove_from_cart, :edit_cart,
              :check_out, :go_to_pay, :pay]

  def index
    @products = Product.where("prod_amount > ?","0" )
    if signed_in?
      @orders = current_user.orders
      @cart_items = current_user.carts
    end
  end

  def show_product
    @product = Product.find(params[:id])
  end

  def show_orders
    @orders = current_user.orders
  end

  def show_order
    @order = Order.find(params[:id])
    unless current_user?(@order.user)
      redirect_to(root_path)
    end
  end

  ## cart

  def show_cart
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart_items = current_user.carts
    cart_item = @cart_items.find{|i| i.product_id == product.id}
    if cart_item
      #cart_item.validate_qty
      if cart_item.amount+1 > cart_item.product.prod_amount
        redirect_to store_show_cart_path, error: "You order too many "+cart_item.product.prod_name+"!"
      else
        cart_item.update_columns( amount: cart_item.amount + 1 )
        redirect_to store_show_cart_path
      end
    else
      cart_item = Cart.new
      cart_item.user_id = current_user.id
      cart_item.product_id = product.id
      cart_item.amount = 1
      @cart_items = current_user.carts
      @cart_items << cart_item
      redirect_to store_show_cart_path
    end
  end

  def remove_from_cart
    cart_item = current_user.carts.find(params[:id])
    if cart_item
      cart_item.delete
    end
    redirect_to store_show_cart_path
  end

  # count of free specified product in cart
  def free_qty_in_other_cart(cart, product)
    free_qty = 0
    current_user.carts.find_all{|i| i.id != cart.id}.each do |c|
      @freebie_rules = c.product.valid_freebies.find_all{|i| i.freebie_id==product.id}
      if @freebie_rules
        @freebie_rules.each do |f|
          fq = ( c.amount / f.prod_qty ).round * f.freebie_qty
          if fq > 0
            free_qty = free_qty + fq
          end
        end
      end
    end
    free_qty
  end

  # count of free specified product 
  def free_qty_to_add(pay_product, qty, free_product)
    f = pay_product.valid_freebies.find{|i| i.freebie_id==free_product.id}
    if f
      free_qty = ( qty / f.prod_qty ).round * f.freebie_qty
    else
      free_qty = 0
    end
  end

  def edit_cart
    cart_item = current_user.carts.find(params[:id])
    new_qty = params[:qty].to_i
    if new_qty < 1
      cart_item.delete
      redirect_to store_show_cart_path, notice: cart_item.product.prod_name+" is removed from cart."
    else
      if new_qty > cart_item.product.prod_amount
        redirect_to store_show_cart_path, error: "Fail to update QTY of "+cart_item.product.prod_name+". You order too many "+cart_item.product.prod_name+"!"
      else
        free_qty_to_be_orderd = free_qty_in_other_cart(cart_item, cart_item.product)
        free_qty_to_be_orderd = free_qty_to_be_orderd + free_qty_to_add(cart_item.product, new_qty, cart_item.product)
        qty_in_stock = cart_item.product.prod_amount - new_qty

        if free_qty_to_be_orderd > qty_in_stock
          cart_item.update_columns( amount: new_qty )
          redirect_to store_show_cart_path, notice: "QTY of "+cart_item.product.prod_name+" is updated. Warning! There is not enough free "+cart_item.product.prod_name+" in stock! Check out will fail for no enough products in stock, please change the QTY."
        else
          cart_item.update_columns( amount: new_qty )
          redirect_to store_show_cart_path, notice: " QTY of "+cart_item.product.prod_name+" is successfully updated."
        end
      end
    end
  end

  def generate_order
    error_msg = ""
    if params[:address].length == 0
      redirect_to store_check_out_path, error: "Empty address!"
    else
      # new order
      new_order = Order.new(session["new_order"])
      new_order.address = params[:address]
      new_order_items = session["new_order_items"]
      current_user.orders << new_order

      # new order items
      productls = []
      new_order_items.each do |i|
        new_item = OrderItem.new(i)
        new_order.order_items << new_item
        p = productls.find {|p| p.id == new_item.product.id }
        if !p
          productls << new_item.product
        end
      end

      # check qty
      productls.each do |p|
        ois = new_order.order_items.find_all {|i| i.product_id == p.id}
        qty = 0
        ois.each do |o|
          qty = qty + o.prod_qty
        end
        if p.prod_amount < qty
          error_msg = error_msg+"There is not enough "+p.prod_name+" in stock! "
        end
      end

      if error_msg.length > 0
        redirect_to store_show_cart_path, error: "Fail to create order! "+error_msg
      else
        # after verify order, update product qty
        productls2 = []
        new_order.order_items.each do |i|
          p = productls2.find {|p| p.id == i.product.id }
          if !p
            productls2 << i.product
          end
        end
        productls2.each do |p|
          ois = new_order.order_items.find_all {|i| i.product_id == p.id}
          qty = 0
          ois.each do |o|
            qty = qty + o.prod_qty
          end
          p.update_columns(prod_amount: p.prod_amount - qty)
        end

        clear_cart
        redirect_to store_show_order_path(:id => new_order.id)
      end
    end
  end

  def check_out
    # generate new order
    order = Order.new
    order.user_id = current_user.id
    order.total_pay = get_cart_total_cost
    session["new_order"] = order

    #generate order items
    order_items = []
    current_user.carts.each do |c|
      new_order_item = OrderItem.new
      new_order_item.order_id = order.id
      new_order_item.product_id = c.product_id
      new_order_item.prod_price = c.price
      new_order_item.discount = c.discount
      new_order_item.prod_qty = c.amount
      new_order_item.sub_pay = c.total_pay_amount
      order_items << new_order_item

      #generate free order items
      c.freebies_in_cart.each do |f|
        new_free_order_item = order_items.find {|i| i.product_id == f.fid && i.prod_price == 0}
        if new_free_order_item
          new_free_order_item.prod_qty = new_free_order_item.prod_qty + f.fqty
        else
          new_free_order_item = OrderItem.new
          new_free_order_item.order_id = order.id
          new_free_order_item.product_id = f.fid
          new_free_order_item.prod_price = 0
          new_free_order_item.discount = 1
          new_free_order_item.prod_qty = f.fqty
          new_free_order_item.sub_pay = 0
          order_items << new_free_order_item
        end
      end
    end
    session["new_order_items"] = order_items
  end

  def share_weibo
  end

  def go_to_pay
    @order = current_user.orders.find(params[:id])
    @pay_amount = @order.total_pay
  end

  def pay
    @order = current_user.orders.find(params[:id])
    @order.update_columns( payed_at: DateTime.now )
    redirect_to store_show_orders_path
  end

  private
    def signed_in_store
      redirect_to(root_path) unless signed_in?
    end
end
