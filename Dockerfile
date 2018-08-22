FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash

RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev nodejs postgresql-client-9.6

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app
