[![Stories in Ready](https://badge.waffle.io/NewCircleMovement/tinkuy.png?label=ready&title=Ready)](https://waffle.io/NewCircleMovement/tinkuy)
[![Build Status](https://travis-ci.org/NewCircleMovement/tinkuy.svg)](https://travis-ci.org/NewCircleMovement/tinkuy)
[![Code Climate](https://d3s6mut3hikguw.cloudfront.net/github/NewCircleMovement/tinkuy/badges/gpa.svg)](https://codeclimate.com/github/NewCircleMovement/tinkuy)
[![Gemnasium](https://gemnasium.com/NewCircleMovement/tinkuy.svg)](https://gemnasium.com/NewCircleMovement/tinkuy)


Website for [tinkuy.dk](https://tinkuy.dk).

# How to build

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

# Testing

There are automated tests, with support for continuous integration through travis.ci. We have two kinds of tests at the moment: unit testing and functional testing

## Unit-testing

We are just using `rake test` which comes built in with ruby. Unfortunately it is a bit out of date, and thus all tests are disabled at the moment; `test/fixtures`, `test/controllers`, etc. needs to be updated before this makes sense.

## Functional testing

Currently we just start the `rails server`, fetch some pages, and compare them with what we expect. This is executed by running `test2/run-blackbox-testing.sh` in the project root, which then reinitialises the `tinkuy_test` database, starts `rails server`, fetches a number of webpages into `test2/result`, and compares that with the expected value in `test2/expected`.
_Important:_ when changes are done that affects the outpage of the pages, this test will likely fail, - verify that the behaviour is as expected, and then move the content of `test2/result` into `test2/expected`.

This is just a quick hack to be able to test, if the application runs, and has the expected output. On the long run, it would make sense to replace this with a selenium tests, or similar. 

# Sample data

There is an sample database in `test2/sample-db.pgsql.xz`. All user information has been anonymised, and every user has the password `12345678`. Some user logins with different roles are:

- 20email@example.com is an admin
- 420email@example.com is a normal member (type 3)
- 147email@example.com is an extended member (type 5)
- 183email@example.com is a professional member (type 6)
- 128email@example.com is passive 

## Migrating sample database

When there are changes in schema, then the sample database needs to be migrated: first load database, then migrate, and then store the new one, ie.:

- createdb tinkuy_development
- xzcat test2/sample-db.pgsql.xz | psql tinkuy_development 
- rake db:migrate RAILS_ENV=development
- pg_dump tinkuy_development | xz -9 > test2/sample-db.pgsql.xz
