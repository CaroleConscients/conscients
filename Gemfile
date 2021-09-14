# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'pg', '>= 0.18'
gem 'puma', '~> 3.11'
gem 'rails', '6.0.4.1'

gem 'friendly_id-mobility'
# Content translation (like Globalize but much better) --> https://github.com/shioyama/mobility
gem 'mobility'
gem 'rails-i18n'

gem 'uglifier'
gem 'webpacker'

gem 'aws-sdk-s3', '~> 1.13', require: false
gem 'jbuilder'
gem 'mini_magick'
gem 'redis'

gem 'bootsnap', require: false
gem 'oj'
gem 'rollbar', '~> 2.15'

gem 'sidekiq'
gem 'sidekiq-failures'

# Analytics for rails --> https://github.com/ankane/ahoy
gem 'ahoy_matey'
gem 'devise'
gem 'devise-i18n'
gem 'devise_invitable'
gem 'gibbon'
gem 'omniauth-facebook'
gem 'postmark-rails'

gem 'activeadmin'
# Thème for activeadmin
gem 'arctic_admin'
# Search for active admin
gem 'ransack'

gem 'acts_as_list'
# Tree structure for models (categories in our case) --> https://github.com/stefankroes/ancestry
gem 'ancestry'
gem 'friendly_id'
# Static pages
gem 'high_voltage'
gem 'meta-tags'
# Clean respond with in controllers
gem 'responders'

gem 'aasm'
gem 'money-rails'
gem 'paypal-sdk-rest', '~> 1.7'
gem 'stripe', '~> 5.1.1'

gem 'kaminari'
gem 'pg_search', '~> 2.1'
gem 'wicked_pdf', '~> 1.1'
gem 'wkhtmltopdf-binary', '~> 0.12'
gem 'wkhtmltopdf-heroku', '~> 2.12', '>= 2.12.4.0'

gem 'country_select'
gem 'font-awesome-rails'
gem 'sass-rails'

gem 'invisible_captcha'

# debugging
gem 'pgsync' # Sync Postgres data between databases (ex: from Production To Development)
gem 'pretender' # login as any user

group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  # gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'letter_opener'
  # Find back messages sent to letter_opener in a web interface
  gem 'letter_opener_web'

  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  gem 'annotate'
  gem 'awesome_print'
  # Possible to desactivate alerts if too annoying
  gem 'bullet'
  # Generate schéma of database automatically in erd.pdf
  gem 'rails-erd'
  gem 'table_print'
  gem 'xray-rails'

  gem 'brakeman', require: false
  gem 'overcommit'
  gem 'rubocop-rails', require: false

  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-livereload', require: false
  gem 'rack-livereload'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console'
end
