module TenantHelper
  def find_tenant
    if ResumisConfig.single_tenant?
      tenant = User.first
    else
      tenant = User.where(:subdomain => request.subdomains.last).first ||
               User.where(:domain => request.domain).first ||
               User.where(:domain => request.host).first
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
    raise ActsAsTenant::Errors::NoTenantSet
  end
end