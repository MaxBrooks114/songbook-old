class User < ApplicationRecord
  has_many :instruments
  has_many :songs
  has_many :elements
end
