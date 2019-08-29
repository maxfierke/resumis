source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
gem 'bootsnap', '>= 1.1.0', require: false
# Use postgresql as the database for Active Record
gem 'pg'
gem 'uglifier', '>= 4.1'
gem 'webpacker'


# JSON-API
gem 'active_model_serializers', '~> 0.10.10'

# ActiveRecord extensions
gem 'acts_as_tenant'
gem 'friendly_id', '~> 5.2.5'
gem 'nilify_blanks'


# Authentication & Authorization
gem 'devise', '~> 4.6.2'
gem 'doorkeeper', '~> 5.1.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'pundit'

# CLI
gem 'thor'

# Image uploads
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'mini_magick'

# Markdown rendering
gem 'redcarpet', '>= 3.2.3'

# Exporting resumes to PDF
gem 'wicked_pdf', '~> 1.4'

# Pagination
gem 'kaminari'
gem 'pager_api', '~> 0.3.2'

# Sidekiq
gem 'hiredis'
gem 'redis-namespace'
gem 'sidekiq', '< 6'
gem 'sidekiq-failures'
gem 'sinatra', '~> 2.0.4', :require => nil # for sidekiq web UI

# Web server
gem 'unicorn'

group :development do
  gem 'listen', '~> 3.1.5'
end

group :production do
  gem 'fog-aws', '~> 3.5'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pundit-matchers', '~> 1.6.0'
end
