class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.string :name
      t.boolean :learned
      t.integer :song_id
      t.integer :instrument_id
      t.integer :user_id

      t.timestamps
    end
  end
end
