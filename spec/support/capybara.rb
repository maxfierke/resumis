require 'capybara/rails'

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :webrick
