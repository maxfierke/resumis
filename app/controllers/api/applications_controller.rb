module Api
  class ApplicationsController < Doorkeeper::ApplicationsController
    before_action :authenticate_user!
    layout "manage"

    def index
      @applications = current_user.oauth_applications
    end

    def create
      @application = Doorkeeper::Application.new(application_params)
      @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
      if @application.save
        flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
        redirect_to oauth_application_path(@application)
      else
        render :new
      end
    end

    private

    def set_application
      @application = current_user.oauth_applications.find(params[:id])
    end
  end
end
