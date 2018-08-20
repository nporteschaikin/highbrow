class AddUniqueIndexToCheckInUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :check_in_users, [:check_in_id, :user_id], unique: true
  end
end
