class ElementSerializer < ActiveModel::Serializer
  attributes :id, :e_name, :tempo, :key, :lyrics, :learned, :full_name

  belongs_to :song
  belongs_to :instrument
end
