class PaymentsController < ApplicationController
  before_action :set_order

  def new
  end

  def create
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
endnts
