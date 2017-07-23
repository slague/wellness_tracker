class RemoveDefaultFromWantsReminder < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :wants_reminder, :boolean 
  end
end
