class Instrument < ApplicationRecord
  # belongs_to :user
  has_many :instruments_songs
  has_many :songs, through: :instruments_songs
  has_many :elements, through: :songs

end
