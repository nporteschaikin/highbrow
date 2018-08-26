class CreateVenueCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :venue_categories do |t|
      t.references :venue, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end

    add_index :venue_categories, [:venue_id, :category_id], unique: true
  end
end
