class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @total_t_shirts = TShirt.count
    @total_categories = Category.count
    @total_users = User.count
  end
end
