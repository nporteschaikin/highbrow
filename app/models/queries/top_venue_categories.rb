module Queries
  TopVenueCategories = Query.new <<~SQL
    select
      categories.name,
      categories.icon_prefix,
      categories.icon_suffix,
      sum(venues.check_ins_count)::integer check_ins_count,
      percentile_cont(0.5) within group (order by venues.rating) p50_rating
    from (
      select
        venues.id,
        venues.name,
        venues.rating,
        count(*) check_ins_count
      from check_ins
      join venues
        on venues.id = check_ins.venue_id
      where check_ins.user_id = :user_id
      group by venues.id
      order by count(*) desc
    ) venues
    join venue_categories
      on venue_categories.venue_id = venues.id
    join categories
      on categories.id = venue_categories.category_id
    group by categories.id
    order by sum(venues.check_ins_count) desc
    limit 10
  SQL
end
