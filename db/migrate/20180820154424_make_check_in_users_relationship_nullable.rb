class MakeCheckInUsersRelationshipNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :check_in_users, :relationship, true
  end
end
