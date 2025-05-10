class CartItem < ApplicationRecord
  belongs_to :t_shirt
  belongs_to :cart

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def total_price
    (t_shirt.price || 0) * (quantity || 0)
  end

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
