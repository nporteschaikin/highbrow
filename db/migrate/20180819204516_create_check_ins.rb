class CreateCheckIns < ActiveRecord::Migration[5.1]
  def change
    create_table :check_ins do |t|
      t.references :check_in_sync, foreign_key: true, null: false
      t.string :external_id, null: false

      t.references :venue, foreign_key: true

      t.integer :likes_count, null: false
      t.integer :comments_count, null: false
      t.boolean :mayor, null: false

      t.datetime :external_created_at, null: false

      t.timestamps
    end

    add_index :check_ins, [:check_in_sync_id, :external_id], unique: true
  end
end
