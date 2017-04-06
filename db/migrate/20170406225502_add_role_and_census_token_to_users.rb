class AddRoleAndCensusTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer
    add_column :users, :census_access_token, :string

  end
end
