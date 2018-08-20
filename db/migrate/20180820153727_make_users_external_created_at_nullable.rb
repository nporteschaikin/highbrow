class MakeUsersExternalCreatedAtNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :external_created_at, true
  end
end
