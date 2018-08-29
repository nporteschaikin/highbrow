class AddFormatRatingFunction < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
      create or replace function format_rating(rating float) returns numeric as $$
      begin
        return round(rating::numeric, 1)::numeric;
      end;
      $$ language plpgsql;
    SQL
  end

  def down
    execute <<~SQL
      drop function format_rating(float);
    SQL
  end
end
