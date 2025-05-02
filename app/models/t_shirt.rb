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
    when 'name_asc'
      order(name: :asc)
    when 'name_desc'
      order(name: :desc)
    else
      all
    end
  }

  #/Sorting////////

  def self.search(params)
    t_shirts = all

    t_shirts = t_shirts.where(category_id: params[:category_id]) if params[:category_id].present?
    t_shirts = t_shirts.where(color: params[:color]) if params[:color].present?
    
    if params[:sorted_by].present?
      case params[:sorted_by]
      when 'price_asc'
        t_shirts = t_shirts.order(price: :asc)
      when 'price_desc'
        t_shirts = t_shirts.order(price: :desc)
      when 'newest'
        t_shirts = t_shirts.order(created_at: :desc)
      when 'oldest'
        t_shirts = t_shirts.order(created_at: :asc)
      when 'name_asc'
        t_shirts = t_shirts.order(name: :asc)
      when 'name_desc'
        t_shirts = t_shirts.order(name: :desc)
      end
    end

    t_shirts
  end

  def average_rating
    opinions.average(:rating).to_f.round(1)
  end
end
