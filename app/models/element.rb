class Element < ApplicationRecord
  include Filterable
  belongs_to :song, inverse_of: :elements
  belongs_to :instrument, inverse_of: :elements
  belongs_to :user, inverse_of: :elements
  has_one_attached :recording
  validates :e_name, uniqueness: { scope: [:instrument, :song_id], message: 'You have already added that element!' }
  validates :tempo, numericality: { only_integer: true },  allow_nil: true
  validate :recording_content_type
  scope :key, -> (key) { where key: key }
  scope :tempo, -> (tempo) { where tempo: tempo }
  scope :e_name, -> (e_name) { where e_name: e_name }
  scope :learned, -> (learned) { where learned: learned }
  scope :song, -> (song) { where song: song }
  scope :lyrics?, -> { where("text_value <> ''") }
  scope :instrument, -> (instrument) { where instrument: instrument }

  attr_accessor :delete_recording

  after_save :purge_recording, if: :delete_recording
  private def purge_recording
    recording.purge_later
  end


  def self.names
    names = [ "Intro", "Verse", "Pre-Chorus", "Chorus", "Bridge", "Coda", "Solo" ]
  end

  def self.keys
    keys = ["C Major", "C# Major", "D Major", "D# Major", "E Major", "F Major",
         "F# Major", "G Major", "G# Major", "A Major", "A# Major", "B Major", "C Minor", "C# Minor", "D Minor", "D# Minor", "E Minor", "F Minor",
              "F# Minor", "G Minor", "G# Minor", "A Minor", "A# Minor", "B Minor" ]
  end


  def self.lyrics?
    select(:lyrics).map { |e| !e.lyrics.blank? }.uniq
  end

  def self.learned_count
    where(learned: true).count
  end

  def self.fastest
    Element.maximum(:tempo)
  end

  def full_name
    "#{self.e_name} to #{self.song.title} on #{self.instrument.i_name}"
  end



  private
    def recording_content_type
      if recording.attached? && !recording.content_type.in?(%w(audio/wav audio/m4a audio/mp3 audio/flac audio/mp4 audio/ogg audio/aif audio/AAC))
        errors.add(:recording, 'must be an audio file!')
      end
    end





end
