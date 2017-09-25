source 'https://rubygems.org'

# environment
gem 'dotenv-rails'

# core application
gem 'rails', '>= 4.2'
gem 'mysql2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# gem 'sdoc', '~> 0.4.0', group: :doc
# gem 'json', '= 2.1.0'

# admin
gem 'devise'
# gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin.git', branch: 'revert-4426-4424-fix-new-with-cast'
# gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin.git', branch: 'master'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'cancancan', '~> 1.15'

# app specific
gem 'formtastic'
gem 'paperclip'
gem 'paperclip-meta'

# bootstrap
gem 'twitter-bootstrap-rails'

# search
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# database
gem 'active_record_union'

# coding tools
gem 'haml', '4'
gem 'haml-rails'
gem 'colorize'

group :production do
  gem 'passenger', '>= 5.0.25', require: 'phusion_passenger/rack_handler'
end

group :development, :test do
  gem 'byebug'
  gem 'jazz_hands2'
end

group :development do
  gem 'spring'

  # debug tools
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'rails-footnotes'
  gem 'web-console', '~> 2.0'

  # better code
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'haml_lint', require: false, git: 'https://github.com/brigade/haml-lint'
  gem 'lol_dba'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rspec', '= 1.5.0'
  gem 'scss_lint', require: false

  # css / sass
  gem 'sass-rails'

  # guard
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop'
  gem 'guard-livereload'
  gem 'guard-compass'
  gem 'guard-brakeman'
  gem 'guard-kjell'
  gem 'guard-process'
  gem 'guard-railsbp'
  gem 'guard-bundler-audit'
  gem 'guard-shell'
  gem 'guard-reek', git: 'https://github.com/gvillalta99/guard-reek'

  # deployment
  gem 'git'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end

group :test do
  gem 'rspec', '=3.4.0'
  gem 'rspec-rails', '=3.4.2'
  gem 'rspec-instafail', '0.5.0'
  gem 'factory_girl_rails'
  gem 'rack-test'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'simplecov', require: false, git: 'https://github.com/colszowka/simplecov'
  gem 'launchy'
end
