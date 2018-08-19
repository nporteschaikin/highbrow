class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :external_id, null: false, index: { unique: true }
      t.datetime :external_created_at, null: false

      # TODO: encrypt later
      t.string :token, null: false

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :city, null: true
      t.string :avatar_url, null: true
      t.string :html_url, null: true

      t.integer :check_ins_count, null: true

      t.timestamps
    end
  end
end
