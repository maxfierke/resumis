module TenantHelper
  def find_tenant
    if ResumisConfig.single_tenant?
      tenant = current_user || User.first
    else
      tenant_scope = User.where(disabled_at: nil)
      tenant = current_user ||
               tenant_scope.find_by(subdomain: request.subdomains.last) ||
               tenant_scope.find_by(domain: request.domain) ||
               tenant_scope.find_by(domain: request.host)
    end

    if tenant
      @current_tenant = tenant
    else
      raise ::Errors::NoTenantSet
    end
  end

  def require_current_tenant_session!
    if user_signed_in? && current_tenant == current_user
      return true
    end

    head :forbidden
  end

  def current_tenant
    @current_tenant
  end
end
