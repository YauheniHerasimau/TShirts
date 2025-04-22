class TShirt < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :opinions, dependent: :destroy

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }

  def average_rating
    opinions.average(:rating).to_f.round(1)
  end
end
