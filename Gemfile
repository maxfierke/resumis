source 'https://rubygems.org'

gem 'rails', '~> 8.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cssbundling-rails', '~> 1.4'
gem 'jsbundling-rails'
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# JSON-API
gem 'active_model_serializers', '~> 0.10.15'

# ActiveRecord extensions
gem 'friendly_id', '~> 5.5.1'
gem 'nilify_blanks'

# Authentication & Authorization
gem 'devise', '~> 4.9.4'
gem 'doorkeeper', '~> 5.8'
gem 'rack-cors', :require => 'rack/cors'
gem 'pundit'

# CLI
gem 'thor'

# Image uploads
gem 'image_processing'

# Markdown rendering
gem 'redcarpet', '>= 3.2.3'

# Exporting resumes to PDF
gem 'wicked_pdf', '~> 2.8'

# Pagination
gem 'kaminari'
gem 'pager_api', '~> 0.3.2'

# Sidekiq
gem 'sidekiq', '< 8'
gem 'sidekiq-failures'

# Web server
gem 'puma'

group :development do
  gem 'listen', '~> 3.9.0'
end

group :production do
  gem 'aws-sdk-s3', require: false

  gem 'fly-ruby', require: false

  gem 'redis'
  gem 'hiredis-client'

  gem 'puma-metrics'

  gem 'sentry-ruby'
  gem 'sentry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 7.1'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'debug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'pundit-matchers', '~> 4.0'
  gem 'selenium-webdriver', '~> 4.30'
end
