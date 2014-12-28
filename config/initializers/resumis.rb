Rails.application.configure do
  # Sets the tenancy mode of the application. Possible values: :single, :multi
  config.x.resumis.tenancy_mode = :single || ENV['RESUMIS_TENANCY_MODE'].to_sym

  # Used for ensuring authentication routes and such point to the right place
  config.x.resumis.canonical_host = 'lvh.me' || ENV['RESUMIS_CANONICAL_HOST']
end
