web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -c 8 -q low,1 -q default,2 -q high,4
clockwork: bundle exec clockwork ./config/clock.rb
