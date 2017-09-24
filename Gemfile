source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.2'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.0.4'

gem 'active_model_serializers', '~> 0.10.0'

# Utilize the bootstrap frontend framework
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'autoprefixer-rails'
gem 'bootswatch-rails'

# Markdown editor and rendering
gem 'rails-bootstrap-markdown'
gem 'redcarpet', '>= 3.2.3'

# Utilize font-awesome iconogrphy set
gem 'font-awesome-sass', '~> 4.3.0'

# Devise for user authentication
gem 'devise', '~> 4.2.0'
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
gem 'sinatra', '~> 2.0.0.rc1', :require => nil # for sidekiq web UI

# pagination
gem 'kaminari'
gem 'pager_api'

gem 'unicorn'

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'listen', '~> 3.0.5'
end

group :production do
  gem 'fog', '~> 1.36.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker', '~> 1.4.3'
  gem 'fuubar'
  gem 'pry-rails'

  # for vulnerability scanning
  gem 'brakeman', :require => false
  gem 'bundler-audit', require: false
end
