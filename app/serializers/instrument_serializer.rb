# frozen_string_literal: true

class InstrumentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :i_name, :family, :range, :make, :model, :display_name, :picture

  has_many :songs
  has_many :elements

  def picture
    if object.picture.attached?
      variant = object.picture.variant(resize: '200x200')
      rails_representation_url(variant, disposition: 'attachment', only_path: true)
    end
   end
end
