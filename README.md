[![Gemnasium](https://img.shields.io/gemnasium/NewCircleMovement/tinkuy.svg?style=flat-square)](https://gemnasium.com/NewCircleMovement/tinkuy)
[![Code Climate](https://img.shields.io/codeclimate/github/NewCircleMovement/tinkuy.svg?style=flat-square)](https://codeclimate.com/github/NewCircleMovement/tinkuy)


Website for [tinkuy.dk](https://tinkuy.dk).

## How to build

- Install ruby on rails, ie. for example with rvm.io (and then source dotfiles)
- install postgresql and postgresql-server-dev
- gem install pg
- bundle install
- fix config/stripe.yml / config/initializers/koudoku.rb
- create pg user "createuser -s -r USERNAME" as postgres
- createdb tinkuy_development
- rake db:migrate RAILS_ENV=development


## README (original ruby notes)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
- System dependencies
- Configuration
- Database creation
- Database initialization
- How to run the test suite
- Services (job queues, cache servers, search engines, etc.)
- Deployment instructions
- ...


## rails-code.txt

(just moved this from codedoc into readme)

  git push heroku master --force
  
  heroku run rake db:migrate
  
  git add -A
  git push
  git commit -m "message" 
  
  git status


... brug git bash!

