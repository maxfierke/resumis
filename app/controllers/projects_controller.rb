class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  layout "public", only: [:index, :show]
  respond_to :html, :json

  def index
    @projects = Project.all
    @project_categories = ProjectCategory.with_projects
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end
end
