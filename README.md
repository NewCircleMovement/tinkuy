[![Stories in Ready](https://badge.waffle.io/NewCircleMovement/tinkuy.png?label=ready&title=Ready)](https://waffle.io/NewCircleMovement/tinkuy)
[![Build Status](https://travis-ci.org/NewCircleMovement/tinkuy.svg)](https://travis-ci.org/NewCircleMovement/tinkuy)
[![Code Climate](https://d3s6mut3hikguw.cloudfront.net/github/NewCircleMovement/tinkuy/badges/gpa.svg)](https://codeclimate.com/github/NewCircleMovement/tinkuy)
[![Gemnasium](https://gemnasium.com/NewCircleMovement/tinkuy.svg)](https://gemnasium.com/NewCircleMovement/tinkuy)


Website for [tinkuy.dk](https://tinkuy.dk).

## How to build

- Install ruby on rails, ie. for example with rvm.io (and then source dotfiles)
- install postgresql and postgresql-server-dev (and postgresql-contrib for rake test)
- gem install pg
- bundle install
- fix config/stripe.yml / config/initializers/koudoku.rb
- create pg user `createuser -s -r $USERNAME` as postgres
- createdb tinkuy_development
- xzcat test2/sample-db.pgsql.xz | psql tinkuy_development 
- rake db:migrate RAILS_ENV=development


start 
- `rails server`
- open localhost:3000 and create user
- `psql tinkuy_development` 

## Testing

There are automated tests, with support for continuous integration through travis.ci. We have two kinds of tests at the moment: unit testing and functional testing

### Unit-testing

We are just using `rake test` which comes built in with ruby. Unfortunately it is a bit out of date, and thus disabled at the moment, - but 

### Functional testing

Currently we just start the `rails server`, fetch some pages, and compare them with what we expect. On the long run, it would make sense to replace this with a selenium test, or similar.
