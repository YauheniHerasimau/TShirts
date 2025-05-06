module Admin
  class TShirtsController < BaseController
    before_action :set_t_shirt, only: [:show, :edit, :update, :destroy, :toggle_hidden]
    def index
      case params[:filter]
      when "hidden"
        @t_shirts = TShirt.hidden.order(created_at: :desc)
      when "visible"
        @t_shirts = TShirt.visible.order(created_at: :desc)
      else
        @t_shirts = TShirt.visible.order(created_at: :desc)
      end
    end
    
    def new
      @t_shirt = TShirt.new
    end

    def show
    end

    def edit
    end
    
    def create
      if !params[:t_shirt] && (params[:name].present? || params[:description].present?)
        @t_shirt = TShirt.create(
          name: params[:name],
          description: params[:description],
          price: params[:price],
          category_id: params[:category_id],
          size: params[:size],
          image_url: params[:image_url]
        )
        if @t_shirt.save
          redirect_to root_path
        end
      else
        @t_shirt = TShirt.create(t_shirt_params)
      end
    end
    
    def destroy
      @t_shirt = TShirt.find(params[:id])
      @t_shirt.destroy
      
      if @t_shirt.destroy
        redirect_to admin_t_shirts_path
      end
    end

    def edit
      @t_shirt = TShirt.find(params[:id])
    end

    def update
      @t_shirt = TShirt.find(params[:id])
      @t_shirt.update(t_shirt_params)
      redirect_to admin_index_path
    end

    def toggle_hidden
      @t_shirt.update(hidden: !@t_shirt.hidden)
      redirect_back(fallback_location: admin_t_shirts_path)
    end

    def update_stock
      @t_shirt = TShirt.find(params[:id])
      current_stock = @t_shirt.stock || 0
      additional_stock = stock_params[:stock].to_i
      total_stock = current_stock + additional_stock
      @t_shirt.update(stock: total_stock)
      redirect_back(fallback_location: admin_t_shirts_path)
    end
    
    private
    
    def t_shirt_params
      params.require(:t_shirt).permit(:name, :description, :price, :category_id, :image_url, :size, :hidden)
    end

    def set_t_shirt
      @t_shirt = TShirt.find(params[:id])
    end

    def stock_params
      params.require(:t_shirt).permit(:stock)
    end
  end
end
