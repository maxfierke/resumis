module Manage
  class ProjectStatusesController < ManageController
    before_action :set_project_status, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def new
      @project_status = ProjectStatus.new(user: current_user)
      authorize @project_status
      respond_with(@project_status, location: manage_projects_path)
    end

    def edit
    end

    def create
      @project_status = ProjectStatus.new(project_status_params)
      authorize @project_status
      @project_status.save
      respond_with(@project_status, location: manage_projects_path)
    end

    def update
      @project_status.update(project_status_params)
      respond_with(@project_status, location: manage_projects_path)
    end

    def destroy
      @project_status.destroy
      respond_with(@project_status, location: manage_projects_path)
    end

    private
      def set_project_status
        @project_status = policy_scope(ProjectStatus).find(params[:id])
        authorize @project_status
      end

      def project_status_params
        params.require(:project_status).permit(:name).merge!(user: current_user)
      end
  end
end
