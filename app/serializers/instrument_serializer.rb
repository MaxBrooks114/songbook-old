class InstrumentSerializer < ActiveModel::Serializer
  attributes :id, :i_name, :family, :range, :make, :model, :display_name

  has_many :songs
  has_many :elements
end
