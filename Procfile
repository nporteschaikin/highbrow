web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -c 15 -q low,1 -q default,2 -q high,4
