[![Stories in Ready](https://badge.waffle.io/NewCircleMovement/tinkuy.png?label=ready&title=Ready)](https://waffle.io/NewCircleMovement/tinkuy)
[![Build Status](https://travis-ci.org/NewCircleMovement/tinkuy.svg)](https://travis-ci.org/NewCircleMovement/tinkuy)
[![Code Climate](https://d3s6mut3hikguw.cloudfront.net/github/NewCircleMovement/tinkuy/badges/gpa.svg)](https://codeclimate.com/github/NewCircleMovement/tinkuy)
[![Gemnasium](https://gemnasium.com/NewCircleMovement/tinkuy.svg)](https://gemnasium.com/NewCircleMovement/tinkuy)


Website for [tinkuy.dk](https://tinkuy.dk).

## How to build

- Install ruby on rails, ie. for example with rvm.io (and then source dotfiles)
- install postgresql and postgresql-server-dev
- gem install pg
- bundle install
- fix config/stripe.yml / config/initializers/koudoku.rb
- create pg user `createuser -s -r $USERNAME` as postgres
- createdb tinkuy_development
- xzcat sample-db.pgsql.xz | psql tinkuy_development 
- rake db:migrate RAILS_ENV=development


start 
- `rails server`
- open localhost:3000 and create user
- `psql tinkuy_development` 
