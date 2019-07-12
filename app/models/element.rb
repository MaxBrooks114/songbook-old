class Element < ApplicationRecord
  belongs_to :song, inverse_of: :elements
  belongs_to :instrument, inverse_of: :elements
  validates :name, presence: true
  validates :tempo, numericality: { only_integer: true },  allow_nil: true

  # belongs_to :user

  def self.names
    names = [ "Intro", "Verse", "Pre-Chrous", "Chorus", "Bridge", "Coda", "Solo" ]
  end

  def self.keys
    keys = ["C Major", "C# Major", "D Major", "D# Major", "E Major", "F Major",
         "F# Major", "G Major", "G Major#", "A Major", "A# Major", "B Major", "C Minor", "C# Minor", "D Minor", "D# Minor", "E Minor", "F Minor",
              "F# Minor", "G Minor", "G# Minor", "A Minor", "A# Minor", "B Minor" ]
  end

  def learned?
    if self.learned
      "Complete"
    else
      "Incomplete"
    end
  end
end
