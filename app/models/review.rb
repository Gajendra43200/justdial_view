class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates  :content,:rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
