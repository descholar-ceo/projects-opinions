class Opinion < ApplicationRecord
  validates :text, presence: true, length: { maximum: 500 }
  belongs_to :user, foreign_key: :author_id
  has_many :comments
end
