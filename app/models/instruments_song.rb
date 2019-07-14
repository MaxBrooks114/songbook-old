class InstrumentsSong < ApplicationRecord
  belongs_to :song, inverse_of: :instruments_songs
  belongs_to :instrument, inverse_of: :instruments_songs
end
