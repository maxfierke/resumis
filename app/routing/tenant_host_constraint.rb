class TenantHostConstraint
  def matches?(request)
    if ResumisConfig.multi_tenant?
      request.subdomain =~ /.+/
    else
      request.subdomain =~ /.*/
    end
  end
end
