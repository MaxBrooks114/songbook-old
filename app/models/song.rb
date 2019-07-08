class Song < ApplicationRecord
  has_many :instruments_songs
  has_many :instruments, through: :instruments_songs
  has_many :elements
  # belongs_to :user
end
