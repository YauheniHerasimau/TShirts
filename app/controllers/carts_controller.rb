class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end

  def checkout
    cart_items = @cart.cart_items

    cart_items.each do |cart_item|
      t_shirt = cart_item.t_shirt
      if t_shirt.stock >= cart_item.quantity
        cart_item.t_shirt.reduce_stock(cart_item.quantity)
      else
        #redirect_to cart_path
      end
    end

  end  
end
