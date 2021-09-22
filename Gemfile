source 'https://rubygems.org'

gem 'rails', '~> 6.0.3'
gem 'bootsnap', '>= 1.1.0', require: false
# Use postgresql as the database for Active Record
gem 'pg'
gem 'webpacker'

# JSON-API
gem 'active_model_serializers', '~> 0.10.12'

# ActiveRecord extensions
gem 'acts_as_tenant', '0.4.3'
gem 'friendly_id', '~> 5.4.2'
gem 'nilify_blanks'

# ActionView extension
gem 'active_link_to', git: 'https://github.com/maxfierke/active_link_to.git', tag: 'v1.0.6-pre_reduce_object_allocations'

# Authentication & Authorization
gem 'devise', '~> 4.7.3'
gem 'doorkeeper', '~> 5.5'
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
gem 'sidekiq', '< 7'
gem 'sidekiq-failures'

# Web server
gem 'unicorn'

group :development do
  gem 'listen', '~> 3.5.1'
end

group :production do
  gem 'aws-sdk-s3', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 5.0'
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
