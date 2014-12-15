class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_by_subdomain_or_domain(:user, :subdomain, :domain)

  rescue_from ActsAsTenant::Errors::NoTenantSet, :with => :handle_no_tenant_set

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

  def after_sign_in_path_for(resource)
    root_url(subdomain: resource.subdomain)
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def handle_no_tenant_set
    render :layout => 'bare',
           :template => 'errors/no_tenant_set'
  end
end
