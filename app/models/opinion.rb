class Opinion < ApplicationRecord
  belongs_to :t_shirt
  belongs_to :user
  
  validates :user, uniqueness: { scope: :t_shirt }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :t_shirt_id }
end
