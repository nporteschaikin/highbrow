## What?

An app that collects your [Swarm][swarm] check-ins.

## Why?

- I wanted to know more about the places I've checked into. I had a hunch that
  the quality of the places I've been to - as per [Foursquare
  ratings][4sq-ratings] - had changed in the years since I moved to NYC.
- I've been writing a lot of SQL at [Code Climate][codeclimate] lately. I
  really enjoy querying data in relational databases.

## Usage

This is [hosted on Heroku][highbrow]. It may not be for long, however: It costs
me $30/mo to use PostgresSQL, Redis, and two dynos.

You can run it locally, too. I wouldn't want to share my check-ins with me,
either. It's pretty simple with [Docker][docker]:

1. Clone the repository.
1. Copy `.env.sample` to `.env` and provide a [Foursquare OAuth client ID and
   secret][4sq-developer].
1. Run `docker-compose up -d`

## I spun this up. There's a scatter chart and two tables. What gives?

I lost interest in this project once I learned that there's nothing interesting
about my check-in history.

[swarm]: https://swarmapp.com
[codeclimate]: https://codeclimate.com
[highbrow]: https://highbrow4sq.heroku.com
[docker]: https://docker.com
[4sq-ratings]: https://medium.com/foursquare-direct/finding-the-perfect-10-how-we-developed-the-foursquare-venue-rating-system-c76b08f7b9b3
[4sq-developer]: https://developer.foursquare.com
