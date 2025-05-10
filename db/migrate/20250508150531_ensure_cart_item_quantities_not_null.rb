class EnsureCartItemQuantitiesNotNull < ActiveRecord::Migration[8.0]
  def change
    CartItem.where(quantity: nil).update_all(quantity: 1)
    change_column_default :cart_items, :quantity, from: nil, to: 1
    change_column_null :cart_items, :quantity, false, 1
  end
end
