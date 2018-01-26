source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.7'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.0.4'

gem 'active_model_serializers', '~> 0.10.7'

# Utilize the bootstrap frontend framework
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'autoprefixer-rails'
gem 'bootswatch-rails'

# Markdown editor and rendering
gem 'rails-bootstrap-markdown'
gem 'redcarpet', '>= 3.2.3'

# Utilize font-awesome iconogrphy set
gem 'font-awesome-sass', '~> 4.7.0'

# Devise for user authentication
gem 'devise', '~> 4.4.1'
gem 'doorkeeper'
gem 'rack-cors', :require => 'rack/cors'

# Exporting resumes to PDF
gem 'wicked_pdf', '~> 1.1'

# because sometimes you need a NULL
gem 'nilify_blanks'

# nice slugged URLs
gem 'friendly_id', '~> 5.1.0'

# Multi-tenancy
gem 'acts_as_tenant'

# Carrierwave for handling uploads to S3
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'mini_magick'

# queues are cool
gem 'hiredis'
gem 'redis-namespace'
gem 'sidekiq', '< 5'
gem 'sidekiq-failures'
gem 'sinatra', '~> 2.0.0', :require => nil # for sidekiq web UI

# pagination
gem 'kaminari'
gem 'pager_api'

gem 'unicorn'

gem 'thor'

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'listen', '~> 3.1.5'
end

group :production do
  gem 'fog-aws', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.7'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.9'
  gem 'faker', '~> 1.8.7'
  gem 'fuubar'
  gem 'pry-rails'
end
