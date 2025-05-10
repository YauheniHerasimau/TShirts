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
        t_shirt.reduce_stock(cart_item.quantity)
      else
        flash[:notice] = "Not enough stock for #{t_shirt.name}. Please adjust your cart."
        redirect_to cart_path
        return
      end
    end

    @cart.cart_items.destroy_all
    redirect_to root_path

  end  
end
