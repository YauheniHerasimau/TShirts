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
    
    redirect_to @cart, notice: "This cart has already been paid." and return if @cart.paid?
  end

  def process_payment
    @cart = current_cart
    
    redirect_to @cart, notice: "This cart has already been paid." and return if @cart.paid?
    
    begin
      payment_intent = Stripe::PaymentIntent.create({
        amount: (@cart.total_price * 100).to_i, # Stripe expects amount in cents
        currency: 'usd',
        payment_method_types: ['card'],
        description: "Cart ##{@cart.id}",
        metadata: {
          cart_id: @cart.id,
          user_id: current_user&.id
        }
      })
      
      @cart.update(stripe_id: payment_intent.id)
      
      render json: { 
        clientSecret: payment_intent.client_secret,
        cart_id: @cart.id
      }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: :unprocessable_entity
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
