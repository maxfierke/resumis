class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :disable_registration, only: [:new, :create, :destroy]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      if resource.persisted?
        ::CreateUserDefaultsJob.perform_later(resource)
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :subdomain, :domain])
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:subdomain, :domain])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if ResumisConfig.multi_tenant?
      manage_dashboard_url(subdomain: resource.subdomain)
    else
      manage_dashboard_url(host: ResumisConfig.canonical_host)
    end
  end

  def after_update_path_for(resource)
    if ResumisConfig.multi_tenant?
      manage_dashboard_url(subdomain: resource.subdomain)
    else
      manage_dashboard_url(host: ResumisConfig.canonical_host)
    end
  end

  def disable_registration
    unless ResumisConfig.multi_tenant?
      head :forbidden
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
