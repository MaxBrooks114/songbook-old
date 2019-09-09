class ElementSerializer < ActiveModel::Serializer
  attributes :id, :e_name, :tempo, :key, :lyrics, :learned

  belongs_to :song
  belongs_to :instrument 
end
