class ChangeWantsReminderOnUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :wants_reminder?, :boolean
  end
end
