class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_by_subdomain_or_domain(:user, :subdomain, :domain)

  rescue_from ActsAsTenant::Errors::NoTenantSet, :with => :handle_no_tenant_set

  def current_tenant
    ActsAsTenant.current_tenant
  end

  def handle_no_tenant_set
    render :layout => 'bare',
           :template => 'errors/no_tenant_set'
  end
end
