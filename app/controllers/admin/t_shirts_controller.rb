module Admin
  class TShirtsController < BaseController
    def index
      @t_shirts = TShirt.all.order(created_at: :desc)
    end
    
    def new
      @t_shirt = TShirt.new
    end
    
    def create
      if !params[:t_shirt] && (params[:name].present? || params[:description].present?)
        @t_shirt = TShirt.new(
          name: params[:name],
          description: params[:description],
          price: params[:price],
          category_id: params[:category_id],
          image_url: params[:image_url]
        )
      else
        @t_shirt = TShirt.new(t_shirt_params)
      end
    end
    
    def destroy
      @t_shirt = TShirt.find(params[:id])
      @t_shirt.destroy
      
      redirect_to admin_root_path
    end
    
    private
    
    def t_shirt_params
      params.require(:t_shirt).permit(:name, :description, :price, :category_id, :image_url)
    end
  end
end
