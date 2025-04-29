class TShirt < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :opinions, dependent: :destroy
  has_one_attached :image

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }

  COLORS = [
    'Black',
    'White',
    'Red', 
    'Blue', 
    'Green', 
    'Yellow', 
    'Purple', 
    'Pink', 
    'Orange', 
    'Gray'
  ]

  validates :color, inclusion: { in: COLORS }, allow_blank: true

  def average_rating
    opinions.average(:rating).to_f.round(1)
  end

  def color_hex
    color_map = {
      'Black' => '#000000',
      'White' => '#ffffff',
      'Red' => '#ff0000',
      'Blue' => '#0000ff',
      'Green' => '#00ff00',
      'Yellow' => '#ffff00',
      'Purple' => '#800080',
      'Pink' => '#ffc0cb',
      'Orange' => '#ffa500',
      'Gray' => '#808080'
    }
    color_map[color] || '#000000'
  end
end
