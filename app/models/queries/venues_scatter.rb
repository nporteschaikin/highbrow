module Queries
  VenuesScatter = Query.new <<~SQL
    select
      venues.name,
      venues.rating,
      count(*) check_ins_count
    from check_ins
    join venues
      on venues.id = check_ins.venue_id
      and venues.rating is not null
    where check_ins.user_id = :user_id
    group by venues.id
  SQL
end
