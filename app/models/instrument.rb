class Instrument < ApplicationRecord
  include Filterable
  belongs_to :user, inverse_of: :instruments
  has_many :instruments_songs, inverse_of: :instrument
  has_many :songs, through: :instruments_songs, inverse_of: :instruments
  has_many :elements, through: :songs, inverse_of: :instrument
  validates :i_name, :range, :family, presence: true
  validates :i_name, uniqueness: { scope: :range}
  scope :range, -> (range) { where range: range}
  scope :family, -> (family) { where family: family}

  def name_with_range
    "#{i_name} (#{range})"
  end

  def self.instrument_list
    instrument_list = ["Accordion", "Air horn", "Bagpipe", "Balalaika", "Banjo", "Barrel drum", "Bass drum", "Bassoon", "Beatboxing", "Bongo drums", "Celesta", "Clarinet", "Cymbal", "Didgeridoo", "Djembe", "Drum", "Drum kit", "Drum machine", "Electric Guitar", "Electronic organ", "English horn",  "Euphonium", "Fingerboard synthesizer", "Flugelhorn", "Flute", "French horn", "Glockenspiel", "Goblet drum", "Guitar", "Hammond organ", "Handpan", "Harmonica", "Harp", "Harpsichord", "Kazoo", "Keyboard", "Keytar", "Lute", "Maktoum", "Mandolin", "Mellotron", "MIDI keyboard", "Oboe", "Ocarina", "Octa-Vibraphone", "Pan flute", "Piano ", "Piccolo", "Pipe organ", "Recorder", "Saxophone", "Sitar", "Slide trumpet", "Snare", "Sousaphone", "Spoon", "Steelpan", "Synthesizer", "Theremin", "Timpani (kettledrum)", "Tom-tom", "Triangle", "Trombone", "Trumpet", "Tsymbaly", "Tuba", "Turntable", "Ukulele", "Vibraphone", "Viola ", "Violin", "Voice", "Wood block", "Xylophone", "Other" ]
  end

  def self.used_families
    select(:family).distinct.map { |i| i.family }
  end

  def self.used_ranges
    select(:range).distinct.map { |i| i.range}
  end

  def self.favorite_range
    group(:range).count.sort_by{|k,v| v}.last.first
  end

  def self.favorite_family
    group(:family).count.sort_by{|k,v| v}.last.first
  end



end
