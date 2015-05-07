module Manage
  class ProjectStatusesController < ManageController
    before_action :set_project_status, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @project_statuses = ProjectStatus.page params[:page]
      respond_with(@project_statuses)
    end

    def new
      @project_status = ProjectStatus.new
      respond_with(@project_status, :location => manage_project_statuses_path)
    end

    def edit
    end

    def create
      @project_status = ProjectStatus.new(project_status_params)
      @project_status.save
      respond_with(@project_status, :location => manage_project_statuses_path)
    end

    def update
      @project_status.update(project_status_params)
      respond_with(@project_status, :location => manage_project_statuses_path)
    end

    def destroy
      @project_status.destroy
      respond_with(@project_status, :location => manage_project_statuses_path)
    end

    private
      def set_project_status
        @project_status = ProjectStatus.find(params[:id])
      end

      def project_status_params
        params.require(:project_status).permit(:name)
      end
  end
end
