class DropCategoriesFromVenues < ActiveRecord::Migration[5.1]
  def change
    remove_column :venues, :categories
  end
end
