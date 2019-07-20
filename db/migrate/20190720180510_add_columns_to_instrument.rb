class AddColumnsToInstrument < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :make, :string
    add_column :instruments, :model, :string
  end
end
