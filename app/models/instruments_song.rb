class InstrumentsSong < ApplicationRecord
  belongs_to :song
  belongs_to :instrument
  belongs_to :user 
end
