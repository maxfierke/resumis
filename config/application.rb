require_relative "boot"
require_relative "initializers/resumis"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Registers some railties, so should happen early
require "initializers/fly"

module Resumis
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.middleware.insert_before 0, Rack::Cors do
      allow do

        if Rails.env.development?
          origins '*'
        else
          origins ENV.fetch('RESUMIS_CORS_ORIGINS', '').split(',')
        end
        resource '/api/*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    # activejob queue adapter
    if Rails.env.test?
      config.active_job.queue_adapter = :test
    else
      config.active_job.queue_adapter = :sidekiq
    end

    config.action_mailer.default_url_options = {
      host: ::ResumisConfig.canonical_host || 'http://localhost:5000'
    }
    Rails.application.routes.default_url_options = config.action_mailer.default_url_options

    config.generators do |g|
      g.test_framework :rspec,
          :fixtures => true,
          :view_specs => false,
          :helper_specs => false,
          :routing_specs => false,
          :controller_specs => true,
          :request_specs => true
      g.fixture_replacement :factory_bot, :dir => "spec/factories"
    end

    config.to_prepare do
      Doorkeeper::ApplicationsController.layout "manage"
      Doorkeeper::AuthorizationsController.layout "application"
      Doorkeeper::AuthorizedApplicationsController.layout "manage"
    end
  end
end
