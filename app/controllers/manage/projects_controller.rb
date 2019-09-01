module Manage
  class ProjectsController < ManageController
    before_action :set_project, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @projects = policy_scope(Project.ordered_by_activity).page(params[:page])
      @project_categories = policy_scope(ProjectCategory).with_projects
      @project_statuses = policy_scope(ProjectStatus).all
      respond_with(@projects)
    end

    def new
      @project = Project.new
      authorize @project
      respond_with(@project)
    end

    def edit
    end

    def create
      @project = Project.new(project_params)
      authorize @project
      @project.save
      respond_with(@project) do |format|
        format.html { redirect_to manage_projects_path }
      end
    end

    def update
      @project.update(project_params)
      respond_with(@project) do |format|
        format.html { redirect_to manage_projects_path }
      end
    end

    def destroy
      @project.destroy
      respond_with(@project, :location => manage_projects_path)
    end

    private
      def set_project
        @project = Project.find(params[:id])
        authorize @project
      end

      def project_params
        params.require(:project).permit(
          :name,
          :short_description,
          :description,
          :start_date,
          :end_date,
          :project_status_id,
          :github_url,
          :vimeo_url,
          :youtube_url,
          :soundcloud_url,
          :bandcamp_url,
          :penflip_url,
          :featured,
          project_category_ids: []
        ).merge!(user: current_user)
      end
  end
end
