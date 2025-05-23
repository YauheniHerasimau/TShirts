class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
  scope :recent, -> { order(created_at: :desc) }
end
