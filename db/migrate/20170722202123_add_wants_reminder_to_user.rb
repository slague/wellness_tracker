class AddWantsReminderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wants_reminder?, :boolean, default: false
  end
end
