class User < ApplicationRecord
  has_many :services
  has_many :reviews
   validates :name, :address, :location, :city, :state, :password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
