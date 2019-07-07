class CreateInstrumentsSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :instruments_songs do |t|
      t.integer :instrument_id
      t.integer :song_id

      t.timestamps
    end
  end
end
