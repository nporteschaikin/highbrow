module Queries
  CheckInScatter = Query.new <<~SQL
    select
      venues.name,
      venues.rating,
      (
        select count(*)
        from check_in_tagged_users
        where check_in_tagged_users.check_in_id = a.id
      ) tagged_users_count,
      (
        select count(*)
        from check_ins b
        where a.user_id = b.user_id
          and a.venue_id = b.venue_id
      ) visits_count
    from check_ins a
    join venues
      on venues.id = a.venue_id
      and venues.rating is not null
    where a.user_id = :user_id
      and a.external_created_at > now() - interval '3 years'
  SQL
end
