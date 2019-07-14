class User < ApplicationRecord
  has_many :instruments
  has_many :instruments_songs
  has_many :songs, through: :instruments_songs
  has_many :elements, through: :songs 
  has_secure_password
  validates :email, :username, :password, :password_confirmation, presence: true
  validates :email, :username, uniqueness: true
end
