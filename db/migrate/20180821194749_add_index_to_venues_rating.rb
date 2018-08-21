class AddIndexToVenuesRating < ActiveRecord::Migration[5.1]
  def change
    add_index :venues, :rating
  end
end
