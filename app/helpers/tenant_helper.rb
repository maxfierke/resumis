module TenantHelper
  def find_tenant
    if ResumisConfig.single_tenant?
      tenant = User.first
    else
      tenant_scope = User.where(disabled_at: nil)
      tenant = tenant_scope.find_by(subdomain: request.subdomains.last) ||
               tenant_scope.find_by(domain: request.domain) ||
               tenant_scope.find_by(domain: request.host)
    end

    set_current_tenant(tenant)
  end

  def require_current_tenant_session!
    if user_signed_in? and current_tenant == current_user
      return true
    end

    head :forbidden
  end

  def current_tenant
    return ActsAsTenant.current_tenant if ActsAsTenant.current_tenant
    return ActsAsTenant.test_tenant if ActsAsTenant.test_tenant && Rails.env.test?
    raise ActsAsTenant::Errors::NoTenantSet
  end
end
