class CreateCheckInSyncs < ActiveRecord::Migration[5.1]
  def change
    create_table :check_in_syncs do |t|
      t.references :user, foreign_key: true, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
