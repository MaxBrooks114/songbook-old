class User < ApplicationRecord
  has_many :instruments, inverse_of: :user
  has_many :songs, inverse_of: :user
  has_many :elements, through: :songs, inverse_of: :user
  has_secure_password
  validates :email, :username, :password, :password_confirmation, presence: true
  validates :email, :username, uniqueness: true
end
