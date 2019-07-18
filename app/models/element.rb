class Element < ApplicationRecord
  include Filterable
  belongs_to :song, inverse_of: :elements
  belongs_to :instrument, inverse_of: :elements
  belongs_to :user, inverse_of: :elements
  validates :e_name, presence: true
  validates :e_name, uniqueness: { scope: [:instrument_id, :song_id] }
  validates :tempo, numericality: { only_integer: true },  allow_nil: true
  scope :key, -> (key) { where key: key }
  scope :tempo, -> (tempo) { where tempo: tempo }
  scope :e_name, -> (e_name) { where e_name: e_name }
  scope :learned, -> (learned) { where learned: learned }
  scope :song, -> (song) { where song: song }
  scope :instrument, -> (instrument) { where instrument: instrument }





  def self.names
    names = [ "Intro", "Verse", "Pre-Chrous", "Chorus", "Bridge", "Coda", "Solo" ]
  end

  def self.keys
    keys = ["C Major", "C# Major", "D Major", "D# Major", "E Major", "F Major",
         "F# Major", "G Major", "G# Major", "A Major", "A# Major", "B Major", "C Minor", "C# Minor", "D Minor", "D# Minor", "E Minor", "F Minor",
              "F# Minor", "G Minor", "G# Minor", "A Minor", "A# Minor", "B Minor" ]
  end



  def self.used_names
    select(:e_name).distinct.map { |e| e.e_name }
  end

  def self.used_keys
    select(:key).distinct.map { |e| e.key }
  end

  def self.used_tempo
    select(:tempo).distinct.map { |e| e.tempo }.reject(&:blank?)
  end

  def self._learned
    select(:learned).distinct.map { |e| e.learned }
  end

  def self.favorite_name
    group(:e_name).count.sort_by{|k,v| v}.last.first
  end

  def self.favorite_key
    group(:key).count.sort_by{|k,v| v}.last.first
  end

  def self.favorite_instrument
    group(:instrument).count.sort_by{|k,v| v}.last.first.i_name
  end

  def self.favorite_song
    group(:song).count.sort_by{|k,v| v}.last.first.title
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






end
