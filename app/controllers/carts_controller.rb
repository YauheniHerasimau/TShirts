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
  def pay
    @cart = current_cart
    @amount = (@cart.total_price * 100).to_i

    @payment_intent = Stripe::PaymentIntent.create({
      amount: @amount,
      currency: 'usd',
      metadata: {
        cart_id: @cart.id
      }
    })
    
    @client_secret = @payment_intent.client_secret
  end

  def process_payment
    @cart = current_cart
    payment_intent_id = params[:payment_intent_id]
    
    begin
      payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)

        @order = Order.create!(
          user: current_user,
          total_amount: @cart.total_price,
          status: 'paid',
          payment_id: payment_intent_id
        )
        
        @cart.cart_items.each do |cart_item|
          OrderItem.create!(
            order: @order,
            product: cart_item.product,
            quantity: cart_item.quantity,
            price: cart_item.product.price
          )
        end
        
        # Empty the cart
        @cart.cart_items.destroy_all
        redirect_to root_path, notice: 'Payment successful! Your order has been processed.'
    end
  end

  def payment_success
    @cart = current_cart
    
    @cart.update(
      payment_status: 'succeeded',
      card_brand: params[:card_brand],
      card_last4: params[:card_last4]
    )
    
    redirect_to @cart, notice: "Payment successful! Your order has been processed."
  end

end
