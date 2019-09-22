# frozen_string_literal: true

class ElementSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :e_name, :tempo, :key, :lyrics, :learned, :full_name, :sheet_music, :recording

  belongs_to :song
  belongs_to :instrument

  def sheet_music
    if object.sheet_music.attached?
      variant = object.sheet_music.variant(resize: '200x200')
      "<img src=\"#{rails_representation_url(variant, only_path: true)}\"/>"
    else
      ' '
    end
  end

  def recording
    if object.recording.attached?
      "<audio controls=\"controls\" src= \"#{rails_blob_path(object.recording, only_path: true)}\"></audio>"
    else
      ' '
    end
  end

  def tempo
    object.tempo.nil? ? '' : object.tempo
  end
end
