class CreateImports < ActiveRecord::Migration[5.1]
  def change
    execute "TRUNCATE TABLE public.check_ins CASCADE"
    drop_table :check_in_users
    drop_table :check_ins
    drop_table :check_in_syncs

    create_table :check_ins do |t|
      t.string :external_id, null: false, index: { unique: true }

      t.references :user, foreign_key: true, null: false
      t.references :venue, foreign_key: true, null: true

      t.integer :likes_count, null: false
      t.integer :comments_count, null: false
      t.boolean :mayor, null: false

      t.datetime :external_created_at, null: false

      t.timestamps
    end

    create_table :check_in_tagged_users do |t|
      t.references :check_in, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :relationship, null: true

      t.timestamps
    end

    add_index :check_in_tagged_users, [:check_in_id, :user_id], unique: true

    create_table :imports do |t|
      t.references :user, foreign_key: true, null: false
      t.string :status, null: false

      t.timestamp
    end

    create_table :import_check_ins do |t|
      t.references :import, foreign_key: true, null: false
      t.references :check_in, foreign_key: true, null: false

      t.timestamp
    end
  end
end
