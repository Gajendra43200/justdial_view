class Service < ApplicationRecord
  belongs_to :user
  has_many :reviews
  enum status: { Open: 'Open', Close: 'Close' }
end
