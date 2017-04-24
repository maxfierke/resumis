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

    # include react addons because awesome
    config.react.addons = true

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
  end
end
