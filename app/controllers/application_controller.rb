class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  set_current_tenant_through_filter
  before_action :find_tenant

  rescue_from ActsAsTenant::Errors::NoTenantSet, :with => :handle_no_tenant_set

  helper_method :canonical_host
  helper_method :multi_tenancy?
  helper_method :latest_resume

  def find_tenant
    if Rails.application.config.x.resumis.tenancy_mode == :single
      tenant = User.find(1)
    else
      tenant = User.where(:subdomain => request.subdomains.last).first || User.where(:domain => request.domain).first || User.where(:domain => request.host).first
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

  def canonical_host
    Rails.application.config.x.resumis.canonical_host || request.host
  end

  def multi_tenancy?
    Rails.application.config.x.resumis.tenancy_mode == :multi
  end

  def latest_resume
    @latest_resume ||= Resume.where(published: true).order(updated_at: :desc).first
  end
end
