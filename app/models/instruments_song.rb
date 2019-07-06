class InstrumentsSong < ApplicationRecord
  belongs_to :song
  belongs_to :instrument
end
