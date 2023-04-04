class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include TenantHelper

  before_action :find_tenant
  rescue_from ::Errors::NoTenantSet, with: :handle_no_tenant_set
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def pundit_user
    PolicyUser.new(current_user, current_tenant)
  end

  def after_sign_in_path_for(resource)
    root_url
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def handle_no_tenant_set
    render template: 'errors/no_tenant_set'
  end
end
