class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :t_shirt
end
