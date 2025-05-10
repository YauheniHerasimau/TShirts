class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    @cart = Cart.find(session[:cart_id])
    t_shirt = TShirt.find(params[:t_shirt_id])
    
    cart_item = @cart.cart_items.find_by(t_shirt_id: t_shirt.id)
    
    if cart_item
      cart_item.update(quantity: cart_item.quantity + 1)
    else
      @cart.cart_items.create(t_shirt: t_shirt, quantity: 1)
    end
    
    redirect_to cart_path
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
