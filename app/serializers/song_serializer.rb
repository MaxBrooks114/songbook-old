# frozen_string_literal: true

class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :lyrics, :genre, :album, :artist

  has_many :instruments
  has_many :elements
end
