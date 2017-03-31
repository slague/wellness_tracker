class AddWeekNumberToWeeks < ActiveRecord::Migration[5.0]
  def change
    add_reference :weeks, :week_number, index: true, foreign_key: true
  end
end
