class Element < ApplicationRecord
  belongs_to :song
  belongs_to :instrument

  # belongs_to :user

  def self.names
    names = ["Intro", "Verse", "Pre-Chrous", "Chorus", "Bridge", "Coda","Solo"]
  end
end
