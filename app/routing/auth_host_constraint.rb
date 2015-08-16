class AuthHostConstraint
  def matches?(request)
    if Rails.application.config.x.resumis.tenancy_mode == :multi
      request.subdomain == 'accounts'
    else
      request.subdomain =~ /.*/
    end
  end
end
