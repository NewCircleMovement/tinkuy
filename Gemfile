source 'https://rubygems.org'
ruby '2.2.3'

# CORS for api
gem 'rack-cors', :require => 'rack/cors'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form', '~> 3.2.0', github: 'plataformatec/simple_form', branch: 'master'

gem 'momentjs-rails', '>= 2.8.1'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.3'

# Enable session storage
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Authentication and permissions
gem 'devise', '~> 3.5.4'
# gem 'cancancan', '~> 1.10'

# Annotate models
gem 'annotate'

# Internationalization
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

# Use postgres
gem "pg"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :staging do
  # Help serving assets in produciton on Heroku
  gem 'rails_12factor'

  
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3' 

  # We love haml... use "rake haml:replace_erbs"
  gem 'erb2haml'

  # Subscriptions (use local developemnt)
  # gem 'koudoku', :path => '~/sites/koudoku'

  # server
  # gem 'thin'
end

# Subscriptions
gem 'koudoku', :git => 'https://github.com/kbjerring/koudoku.git'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
