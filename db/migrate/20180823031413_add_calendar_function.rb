class AddCalendarFunction < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
      create function calendar(start_date date, end_date date, step character) returns table(period date) AS $$
        select date_trunc(calendar.step, n::timestamp)::date as period
        from generate_series(calendar.start_date, calendar.end_date, ('1 ' || calendar.step)::interval) n
      $$ LANGUAGE sql STABLE;
    SQL
  end

  def down
    execute "drop function calendar(date, date, character);"
  end
end
