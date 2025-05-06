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
    # Start a transaction to ensure all stock updates happen together or not at all
    ActiveRecord::Base.transaction do
      success = true
      out_of_stock_items = []
      
      # Get the current user's cart items
      cart_items = @cart.cart_items
      
      # Try to reduce stock for each item
      cart_items.each do |cart_item|
        t_shirt = cart_item.t_shirt
        unless t_shirt.reduce_stock(cart_item.quantity)
          success = false
          out_of_stock_items << t_shirt.name
        end
      end
      
      # If we get here, all stock reductions were successful
      # Create the order (assuming you have an Order model)
      @order = Order.new(
        user: current_user,
        total_amount: @cart.total_price
        # Add other necessary order attributes
      )
      
      if @order.save
        # Move items from cart to order items
        cart_items.each do |cart_item|
          OrderItem.create(
            order: @order,
            t_shirt: cart_item.t_shirt,
            quantity: cart_item.quantity,
            price: cart_item.t_shirt.price
          )
        end
        
        # Clear the cart
        @cart.cart_items.destroy_all
        
        redirect_to order_path(@order), notice: "Order placed successfully!"
      else
        # If order creation fails, rollback the transaction
        raise ActiveRecord::Rollback, "Failed to create order"
      end
    end
  end  
end
