module Charts
  class Rating < Chart
    def to_json
      {
        type: "line",
        data: {
          labels: ratings.map(&:period),
          datasets: [
            {
              label: "Median",
              data: ratings.map(&:p50_rating),
              fill: false,
            },
            {
              label: "90th percentile",
              data: ratings.map(&:p90_rating),
              fill: false,
            },
          ],
        }
      }
    end

    private

    def ratings
      @ratings ||= Query.new(<<~SQL, params.merge(user_id: user.id))
        select
          calendar.period,
          round(percentile_cont(0.5) within group (order by venues.rating asc)::numeric, 2)::float as p50_rating,
          round(percentile_cont(0.9) within group (order by venues.rating asc)::numeric, 2)::float as p90_rating
        from calendar((now() - interval '5 years')::date, current_date, 'month')
        left outer join check_ins
          on date_trunc('month', check_ins.external_created_at) = calendar.period
        left outer join venues
          on venues.id = check_ins.venue_id
        where user_id = :user_id
        group by 1
      SQL
    end
  end
end
