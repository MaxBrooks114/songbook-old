# frozen_string_literal: true

class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :lyrics, :genre, :album

  has_many :instruments
  has_many :elements
end
