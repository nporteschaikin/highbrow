source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.5'
gem 'sidekiq'
gem 'clockwork'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'oauth2'
gem 'active_record_upsert', '~> 0.7.0'
gem 'uglifier', '>= 1.3.0'
gem 'faraday'
gem 'faraday_middleware'
gem 'newrelic_rpm'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Added at 2018-08-21 17:55:59 -0400 by npc:
gem "bugsnag", "~> 6.8"
