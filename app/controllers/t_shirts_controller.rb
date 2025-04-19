class TShirtsController < ApplicationController

    def index
        @t_shirts = TShirt.all
    end

    def show
        @t_shirt = TShirt.find(params[:id])
    end

    def destroy
        @t_shirt = TShirt.find(params[:id])
        @t_shirt.destroy

        redirect_to root_path
    end

    def edit
        @t_shirt = TShirt.find(params[:id])
    end
end
