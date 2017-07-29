class CreateModsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :mods do |t|
      t.string :inning
    end
  end
end
