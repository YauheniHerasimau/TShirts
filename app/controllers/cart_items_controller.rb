class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    t_shirt = TShirt.find(params[:t_shirt_id])
    @cart_item = @cart.add_t_shirt(t_shirt)

    redirect_to cart_path(@cart)
  end

  def update
    @cart_item.update(cart_item_params)
    redirect_to cart_path(@cart_item.cart)
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path(@cart_item.cart)
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
