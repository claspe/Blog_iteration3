class Comment < ApplicationRecord
  belongs_to :post
  validates :post, presence: true
  validates :body, presence: true
end
