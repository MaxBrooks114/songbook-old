class CreateInstruments < ActiveRecord::Migration[5.2]
  def change
    create_table :instruments do |t|
      t.string :name
      t.string :family
      t.string :range

      t.timestamps
    end
  end
end
