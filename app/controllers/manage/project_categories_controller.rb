module Manage
  class ProjectCategoriesController < ManageController
    before_action :set_project_category, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def new
      @project_category = ProjectCategory.new(user: current_user)
      authorize @project_category
      respond_with(@project_category, location: manage_projects_path)
    end

    def edit
    end

    def create
      @project_category = ProjectCategory.new(project_category_params)
      authorize @project_category
      @project_category.save
      respond_with(@project_category, location: manage_projects_path)
    end

    def update
      @project_category.update(project_category_params)
      respond_with(@project_category, location: manage_projects_path)
    end

    def destroy
      @project_category.destroy
      respond_with(@project_category, location: manage_projects_path)
    end

    private
      def set_project_category
        @project_category = policy_scope(ProjectCategory).find(params[:id])
        authorize @project_category
      end

      def project_category_params
        params.require(:project_category).permit(:name).merge!(user: current_user)
      end
  end
end
