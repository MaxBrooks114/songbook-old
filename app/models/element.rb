class Element < ApplicationRecord
  belongs_to :song, inverse_of: :elements
  belongs_to :instrument, inverse_of: :elements

  # belongs_to :user

  def self.names
    names = ["Intro", "Verse", "Pre-Chrous", "Chorus", "Bridge", "Coda","Solo"]
  end

  def learned?
    if self.learned
      "learned"
    else
      "Need to learn"
    end
  end
end
