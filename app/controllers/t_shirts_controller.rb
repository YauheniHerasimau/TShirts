class TShirtsController < ApplicationController
    def index
        @t_shirts = TShirt.all
    end

    def show
        @t_shirt = TShirt.find(params[:id])
    end
end
