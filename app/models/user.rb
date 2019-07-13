class User < ApplicationRecord
  has_many :instruments
  has_many :songs
  has_many :elements
  has_secure_password
  validates :email, :username, :password, :password_confirmation, presence: true
  validates :email, :username, uniqueness: true 
end
