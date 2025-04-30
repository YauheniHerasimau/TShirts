class TShirtsController < ApplicationController

    def index
        @categories = Category.all
        @colors = TShirt::COLORS

        @t_shirts = TShirt.visible

        if params[:category_id].present?
            @t_shirts = TShirt.where(category_id: params[:category_id])
        else
            @t_shirts = TShirt.all.order(created_at: :desc)
        end

        if params[:color].present?
            @t_shirts = @t_shirts.by_color(params[:color])
        else
            @t_shirts = @t_shirts.all.order(created_at: :desc)
        end

        @t_shirts = @t_shirts.sorted_by(params[:sort_by])
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
        @t_shirt.destroy

        redirect_to root_path
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
        params.require(:t_shirt).permit(:name, :description, :price, :category_id, :image_url, :size, :color)
    end
end
