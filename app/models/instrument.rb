class Instrument < ApplicationRecord
  # belongs_to :user
  has_many :instruments_songs
  has_many :songs, through: :instruments_songs
  has_many :elements, through: :songs
  validates :type, :range, :family, presence: true
  validates :type, uniqueness: { scope: :range}
  before_save :normalize


  def type_with_range
    "#{type} (#{range})"
  end

  def self.instrument_list
    instrument_list = ["Accordion", "Air horn", "Bagpipe", "Balalaika", "Banjo", "Barrel drum", "Bass drum", "Bassoon", "Beatboxing", "Bongo drums", "Celesta", "Clarinet", "Cymbal", "Didgeridoo", "Djembe", "Drum", "Drum kit", "Drum machine", "Electronic organ", "English horn",  "Euphonium", "Fingerboard synthesizer", "Flugelhorn", "Flute", "French horn", "Glockenspiel", "Goblet drum", "Guitar", "Hammond organ", "Handpan", "Harmonica", "Harp", "Harpsichord", "Kazoo", "Keyboard", "Keytar", "Lute", "Maktoum (maktoom, katem)", "Mandolin", "Mellotron", "MIDI keyboard", "Oboe", "Ocarina", "Octa-Vibraphone", "Pan flute", "Piano ", "Piccolo", "Pipe organ", "Recorder", "Saxophone", "Sitar", "Slide trumpet", "Snare", "Sousaphone", "Spoon", "Steelpan", "Synthesizer", "Theremin", "Timpani (kettledrum)", "Tom-tom", "Triangle", "Trombone", "Trumpet", "Tsymbaly", "Tuba", "Turntable", "Ukulele", "Vibraphone", "Viola ", "Violin", "Voice", "Wood block", "Xylophone", "Other" ]
  end


  private
    def normalize
      self.type = type.downcase.titleize.squish
    end
end
