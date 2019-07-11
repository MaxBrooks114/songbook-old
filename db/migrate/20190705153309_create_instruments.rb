class CreateInstruments < ActiveRecord::Migration[5.2]
  def change
    create_table :instruments do |t|
      t.string :type
      t.string :family
      t.string :range
      t.integer :user_id

      t.timestamps
    end
  end
end
