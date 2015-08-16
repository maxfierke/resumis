class TenantHostConstraint
  def matches?(request)
    if Rails.application.config.x.resumis.tenancy_mode == :multi
      request.subdomain =~ /.+/
    else
      request.subdomain =~ /.*/
    end
  end
end
