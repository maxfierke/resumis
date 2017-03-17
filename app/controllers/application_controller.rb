class ApplicationController < ActionController::Base
  include ResumisConfig
  include TenantHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_through_filter
  before_action :find_tenant
  rescue_from ActsAsTenant::Errors::NoTenantSet, :with => :handle_no_tenant_set

  def after_sign_in_path_for(resource)
    if multi_tenancy?
      root_url(subdomain: resource.subdomain)
    else
      root_url(host: canonical_host)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def handle_no_tenant_set
    render :layout => 'bare',
           :template => 'errors/no_tenant_set'
  end
end
