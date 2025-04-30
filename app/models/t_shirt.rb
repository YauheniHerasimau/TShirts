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
  scope :by_category, ->(category_id) { where(category_id: category_id)  if category_id.present? } 
  scope :by_color, ->(color) { where(color: color) if color.present? }

  #Sorting/////////

  scope :sorted_by, ->(sort_param) {
    case sort_param
    when 'price_asc'
      order(price: :asc)
    when 'price_desc'
      order(price: :desc)
    when 'newest'
      order(created_at: :desc)
    when 'oldest'
      order(created_at: :asc)
    else
      all
    end
  }

  #/Sorting////////

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

  def self.search(params)
    t_shirts = all
    t_shirts = t_shirts.where(category_id: params[:category_id]) if params[:category_id].present?
    t_shirts
  end
end
