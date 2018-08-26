module Queries
  CategoryPie = Query.new <<~SQL
    select
      unnest(venues.categories) as name,
      count(*)
    from check_ins
    join venues
      on venues.id = check_ins.venue_id
    where check_ins.user_id = :user_id
    group by unnest(venues.categories)
    order by count(*) desc
    limit 10
  SQL
end
