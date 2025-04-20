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
    
    private
    
    def t_shirt_params
      params.require(:t_shirt).permit(:name, :description, :price, :category_id, :image_url, :size)
    end
  end
end
