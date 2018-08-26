class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :external_id, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :icon_prefix, null: true
      t.string :icon_suffix, null: true

      t.timestamps
    end
  end
end
