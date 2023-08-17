class Service < ApplicationRecord
  belongs_to :user
  has_many :reviews
  enum status: { Open: 'Open', Close: 'Close' }
  validates :service_name, :status, :location, :city, presence: true
end
