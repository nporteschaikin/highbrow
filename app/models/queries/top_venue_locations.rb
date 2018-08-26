module Queries
  TopVenueLocations = Query.new <<~SQL
    select
      city,
      state,
      country_code,
      count(*) venues_count,
      percentile_cont(0.5) within group (order by locations.rating) p50_rating
    from (
      select distinct on (venues.id)
        venues.id,
        venues.location_city city,
        venues.location_state state,
        venues.location_country_code country_code,
        venues.rating
      from check_ins
      join venues
        on venues.id = check_ins.venue_id
      where check_ins.user_id = :user_id
    ) locations
    group by 1, 2, 3
    order by 4 desc
    limit 10
  SQL
end
