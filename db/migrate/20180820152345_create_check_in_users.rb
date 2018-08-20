class CreateCheckInUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :check_in_users do |t|
      t.references :check_in, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :relationship, null: false

      t.timestamps
    end
  end
end
