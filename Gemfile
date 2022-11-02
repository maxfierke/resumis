source 'https://rubygems.org'

gem 'rails', '~> 7.0.4'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cssbundling-rails', '~> 1.1'
gem 'jsbundling-rails'
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# JSON-API
gem 'active_model_serializers', '~> 0.10.13'

# ActiveRecord extensions
gem 'acts_as_tenant', '~> 0.5.1'
gem 'friendly_id', '~> 5.4.2'
gem 'nilify_blanks'

# Authentication & Authorization
gem 'devise', '~> 4.8.1'
gem 'doorkeeper', '~> 5.6'
gem 'rack-cors', :require => 'rack/cors'
gem 'pundit'

# CLI
gem 'thor'

# Image uploads
gem 'image_processing'

# Markdown rendering
gem 'redcarpet', '>= 3.2.3'

# Exporting resumes to PDF
gem 'wicked_pdf', '~> 2.1'

# Pagination
gem 'kaminari'
gem 'pager_api', '~> 0.3.2'

# Sidekiq
gem 'hiredis'
gem 'redis-namespace'
gem 'sidekiq', '< 8'
gem 'sidekiq-failures'

# Web server
gem 'unicorn'

group :development do
  gem 'listen', '~> 3.7.1'
end

group :production do
  gem 'aws-sdk-s3', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pundit-matchers', '~> 1.7.0'
end
