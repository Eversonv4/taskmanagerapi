FROM ruby:3.3.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libpq-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .