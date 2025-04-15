class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  
  def index
    @t_shirts = TShirt.all.order(created_at: :desc)
  end
  
  def create_t_shirt
    @t_shirt = TShirt.new(t_shirt_params)
    
    if @t_shirt.save
      redirect_to admin_path
    end
  end
  
  private
  
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
  
  def t_shirt_params
    params.permit(:name, :description, :price, :sku, :category_id, :color_id)
  end
end
