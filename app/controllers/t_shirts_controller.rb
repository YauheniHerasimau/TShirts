class TShirtsController < ApplicationController

    def index
        if current_user && current_user.admin?
            params[:admin_viev] = 'true'
        end

        @t_shirts = TShirt.search(params)
        @categories = Category.all
    end

    def show
        @t_shirt = TShirt.visible.find(params[:id])

        @opinions = @t_shirt.opinions
        @opinion = Opinion.create

    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def destroy
        @t_shirt = TShirt.find(params[:id])

        CartItem.where(t_shirt_id: @t_shirt.id).destroy_all
        @t_shirt.opinions.destroy_all
        @t_shirt.destroy

        redirect_to t_shirts_path
    end

    def edit
        @t_shirt = TShirt.find(params[:id])
    end

    def update
        @t_shirt = TShirt.find(params[:id])
        @t_shirt.update(t_shirt_params)
        redirect_to root_path
    end

    private

    def t_shirt_params
        params.require(:t_shirt).permit(:name, :description, :price, :category_id, :image_url, :size, :color, :stock)
    end
end
