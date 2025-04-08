class Category < ApplicationRecord
  has_many :t_shirts
  validates :name, presence: true
end
