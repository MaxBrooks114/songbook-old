class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.string :artist
      t.string :genre
      t.string :album
      t.boolean :learned
      t.integer :user_id

      t.timestamps
    end
  end
end
