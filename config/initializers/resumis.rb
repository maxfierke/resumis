Rails.application.configure do
  # Sets the tenancy mode of the application. Possible values: :single, :multi
  config.x.resumis.tenancy_mode = ENV['RESUMIS_TENANCY_MODE'] ? ENV['RESUMIS_TENANCY_MODE'].to_sym : :single

  # Used for ensuring authentication routes and such point to the right place
  config.x.resumis.canonical_host = ENV['RESUMIS_CANONICAL_HOST'].presence || 'lvh.me'

  config.x.resumis.excluded_subdomains = ENV['RESUMIS_EXCLUDED_SUBDOMAINS'] ? ENV['RESUMIS_EXCLUDED_SUBDOMAINS'].split(',') : %w(mail auth api service login signup accounts account users ftp ldap webmail manage admin)

  config.x.resumis.google_client_id = ENV['RESUMIS_GOOGLE_CLIENT_ID']
end
