class TShirtsController < ApplicationController
    def index
        @t_shirts = TShirt.all
    end
end
