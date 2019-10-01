source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
gem 'bootsnap', '>= 1.1.0', require: false
# Use postgresql as the database for Active Record
gem 'pg'
gem 'webpacker'


# JSON-API
gem 'active_model_serializers', '~> 0.10.10'

# ActiveRecord extensions
gem 'acts_as_tenant', '0.4.3'
gem 'friendly_id', '~> 5.3.0'
gem 'nilify_blanks'

# ActionView extension
gem 'active_link_to', git: 'https://github.com/maxfierke/active_link_to.git', tag: 'v1.0.6-pre_reduce_object_allocations'

# Authentication & Authorization
gem 'devise', '~> 4.7.1'
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
gem 'sidekiq', '< 7'
gem 'sidekiq-failures'
gem 'sinatra', '~> 2.0.7', :require => nil # for sidekiq web UI

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
