class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :disable_registration, only: [:new, :create, :destroy]

  layout "bare"

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
    devise_parameter_sanitizer.permit(:sign_up) << [:first_name, :last_name, :subdomain, :domain]
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) << [:subdomain, :domain]
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if multi_tenancy?
      profile_url(subdomain: resource.subdomain)
    else
      profile_url(host: canonical_host)
    end
  end

  def after_update_path_for(resource)
    if multi_tenancy?
      profile_url(subdomain: resource.subdomain)
    else
      profile_url(host: canonical_host)
    end
  end

  def disable_registration
    unless multi_tenancy?
      head :forbidden
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
