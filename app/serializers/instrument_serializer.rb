class InstrumentSerializer < ActiveModel::Serializer
  attributes :id, :i_name, :family, :range, :make, :model

  has_many :songs
  has_many :elements
end
