class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :t_shirts, through: :cart_items

    def add_t_shirt(t_shirt)
        current_item = cart_items.find_by(t_shirt_id: t_shirt.id)

        if current_item
            current_item.quantity += 1
        else
            current_item = cart_items.create(t_shirt_id: t_shirt.id)
        end
        current_item
    end

    def total_price
        cart_items.sum do |item|
            item.t_shirt ? (item.t_shirt.price || 0) * (item.quantity || 0) : 0
        end
    end

    def total_items
        cart_items.sum(:quantity)
    end
end
