class AuthHostConstraint
  def matches?(request)
    if ResumisConfig.multi_tenant?
      request.subdomain == 'accounts'
    else
      request.subdomain =~ /.*/
    end
  end
end
