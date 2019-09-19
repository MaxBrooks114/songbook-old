# frozen_string_literal: true

class InstrumentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :i_name, :family, :range, :make, :model, :display_name, :picture

  has_many :songs
  has_many :elements

  def picture
    rails_blob_path(object.picture, disposition: 'attachment', only_path: true) if object.picture.attached?
   end
end
