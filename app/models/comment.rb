class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :content, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
