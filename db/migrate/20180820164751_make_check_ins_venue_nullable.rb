class MakeCheckInsVenueNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :check_ins, :venue_id, null: true
  end
end
