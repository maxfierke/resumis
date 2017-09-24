require_relative 'boot'
require_relative 'initializers/resumis'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Resumis
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

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
    config.active_job.queue_adapter = :sidekiq

    if Rails.env.development?
      config.action_mailer.default_url_options = { host: ::ResumisConfig.canonical_host }
    end

    config.generators do |g|
      g.test_framework :rspec,
          :fixtures => true,
          :view_specs => false,
          :helper_specs => false,
          :routing_specs => false,
          :controller_specs => true,
          :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    config.to_prepare do
      Doorkeeper::ApplicationsController.layout "manage"
      Doorkeeper::AuthorizationsController.layout "bare"
      Doorkeeper::AuthorizedApplicationsController.layout "manage"
    end
  end
end
