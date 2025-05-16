class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def require_admin
    unless current_user.admin? && user_signed_in?
      redirect_to root_path, alert: 'You do not have permission to access this page.'
    end
  end

  def current_cart
    if session[:cart_id].present?
      cart = Cart.find_by(id: session[:cart_id])
      return cart if cart.present?
    end

    cart = if current_user
             Cart.find_or_create_by(user_id: current_user.id)
           else
             Cart.create
           end
    
    session[:cart_id] = cart.id
    cart
  end
end
