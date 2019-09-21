# frozen_string_literal: true

class ElementSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :e_name, :tempo, :key, :lyrics, :learned, :full_name, :sheet_music, :recording

  belongs_to :song
  belongs_to :instrument

  def sheet_music
    rails_blob_path(object.sheet_music, disposition: 'attachment', only_path: true) if object.sheet_music.attached?
  end

  def recording
    rails_blob_path(object.recording, only_path: true) if object.recording.attached?
  end

  def tempo
    object.tempo.nil? ? '' : object.tempo
  end
end
