class Instrument < ApplicationRecord
  include Filterable
  belongs_to :user, inverse_of: :instruments
  has_many :instruments_songs, inverse_of: :instrument
  has_many :songs, through: :instruments_songs, inverse_of: :instruments
  has_many :elements, through: :songs, inverse_of: :instrument
  has_one_attached :picture
  validate :picture_content_type
  scope :range, -> (range) { where range: range}
  scope :family, -> (family) { where family: family}
  scope :make, -> (make) { where make: make}
  before_save :normalize

  attr_accessor :delete_picture

  after_save :purge_picture, if: :delete_picture
  private def purge_picture
    picture.purge_later
  end

  def self.instrument_list
    instrument_list = ["Accordion", "Air horn", "Bagpipe", "Balalaika", "Banjo", "Barrel drum", "Bass drum", "Bassoon", "Beatboxing", "Bongo drums", "Celesta", "Clarinet", "Cymbal", "Didgeridoo", "Djembe", "Drum", "Drum kit", "Drum machine", "Electric Guitar", "Electronic organ", "English horn",  "Euphonium", "Fingerboard synthesizer", "Flugelhorn", "Flute", "French horn", "Glockenspiel", "Goblet drum", "Guitar", "Hammond organ", "Handpan", "Harmonica", "Harp", "Harpsichord", "Kazoo", "Keyboard", "Keytar", "Lute", "Maktoum", "Mandolin", "Mellotron", "MIDI keyboard", "Oboe", "Ocarina", "Octa-Vibraphone", "Pan flute", "Piano ", "Piccolo", "Pipe organ", "Recorder", "Saxophone", "Sitar", "Slide trumpet", "Snare", "Sousaphone", "Spoon", "Steelpan", "Synthesizer", "Theremin", "Timpani (kettledrum)", "Tom-tom", "Triangle", "Trombone", "Trumpet", "Tsymbaly", "Tuba", "Turntable", "Ukulele", "Vibraphone", "Viola ", "Violin", "Voice", "Wood block", "Xylophone", "Other" ]
  end

  def name_with_range
    "#{i_name} (#{range})"
  end

  def make_with_model_name
    "#{make} #{model} (#{i_name})"
  end

  def display_name
    if make.blank? || model.blank?
      name_with_range
    else
      make_with_model_name
    end
  end

  private

  def normalize
    self.make = make.downcase.titleize.squish
    self.model = model.downcase.titleize.squish
  end

  def picture_content_type
    if picture.attached? && !picture.content_type.in?(%w(image/pdf image/JPEG image/png image/jpg image/jpeg))
      errors.add(:picture, 'must be an image file!')
    end
  end


end
