class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :opinions, dependent: :destroy
  has_many :orders
  has_many :messages, dependent: :destroy
  def admin?
    admin == true
  end
end
