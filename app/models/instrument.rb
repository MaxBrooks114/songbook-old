class Instrument < ApplicationRecord
  # belongs_to :user
  has_many :instruments_songs
  has_many :songs, through: :instruments_songs
  has_many :elements, through: :songs
  validates :name, :range, :family, presence: true
  validates :name, uniqueness: { scope: :range}


  def name_with_range
    "#{name} (#{range})"
  end
end
