class MakeUserTokenNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :token, true
  end
end
