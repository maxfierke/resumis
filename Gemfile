source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Utilize the bootstrap frontend framework
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'autoprefixer-rails'
gem 'bootswatch-rails'

# Markdown editor and rendering
gem 'rails-bootstrap-markdown'
gem 'redcarpet'

# Utilize font-awesome iconogrphy set
gem 'font-awesome-sass', '~> 4.2.0'

# Devise for user authentication
gem 'devise', '~> 3.4.1'

# Exporting resumes to PDF
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

# for encoding emails to prevent harvesting
gem 'actionview-encoded_mail_to'


group :development do
  # use capistrano for deployment
  gem 'capistrano-rails'

  # improve error pages
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  # use unicorn to run the app on production
  gem 'unicorn'
end
