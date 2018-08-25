module Queries
  MostTaggedUsers = Query.new <<~SQL
    select
      users.first_name,
      users.last_name,
      users.photo_prefix,
      users.photo_suffix,
      count(*)
    from check_ins
    join check_in_tagged_users
      on check_in_tagged_users.check_in_id = check_ins.id
    join users
      on users.id = check_in_tagged_users.user_id
    join venues
      on venues.id = check_ins.venue_id
    where check_ins.user_id = :user_id
      and check_ins.external_created_at > now() - interval '3 years'
    group by users.id
    order by count(*) desc
    limit 10
  SQL
end
