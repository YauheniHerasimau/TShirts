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
end
