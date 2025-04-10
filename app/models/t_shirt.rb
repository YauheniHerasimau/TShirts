class TShirt < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true
end
