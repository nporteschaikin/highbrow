module Queries
  VenuesScatter = Query.new <<~SQL
    select
      venues.name,
      venues.rating,
      venues.categories,
      count(*) check_ins_count,
      (
        select count(distinct(check_in_tagged_users.user_id))
        from check_ins ci1
        join check_in_tagged_users
          on check_in_tagged_users.check_in_id = ci1.id
        where ci1.user_id = :user_id
          and ci1.venue_id = venues.id
      ) distinct_tagged_users_count
    from check_ins
    join venues
      on venues.id = check_ins.venue_id
      and venues.rating is not null
    where check_ins.user_id = :user_id
    group by venues.id
  SQL
end
