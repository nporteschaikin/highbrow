class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :external_id, null: false, index: { unique: true }

      t.string :name, null: false
      t.string :categories, array: true, null: false

      t.float :location_lat, null: false
      t.float :location_lng, null: false
      t.string :location_country_code, null: false
      t.string :location_country, null: false
      t.string :location_address, null: true
      t.string :location_formatted_address, array: true, null: false
      t.string :location_city, null: true
      t.string :location_state, null: true
      t.string :location_postal_code, null: true

      #t.boolean :verified, null: true

      #t.string :contact_phone, null: true
      #t.string :contact_facebook_id, null: true
      #t.string :contact_facebook_username, null: true
      #t.string :contact_facebook_name, null: true

      t.float :rating, null: true
      #t.string :rating_color, null: true
      #t.string :rating_signals, null: true

      #t.datetime :external_created_at, null: true

      #t.integer :external_tips_count, null: false
      #t.integer :external_users_count, null: false
      #t.integer :external_check_ins_count, null: false

      t.string :rating_sync_status, null: true
      t.datetime :rating_last_synced_at, null: true

      t.timestamps
    end
  end
end
