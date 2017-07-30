class AddModToWeeks < ActiveRecord::Migration[5.0]
  def change
    add_reference :weeks, :mod, index: true, foreign_key: true
  end
end
