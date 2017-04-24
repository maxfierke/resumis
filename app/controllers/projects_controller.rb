class ProjectsController < ApplicationController
  layout "public", only: [:index, :show]

  def index
    @projects = Project.all
    @project_categories = ProjectCategory.with_projects
  end

  def show
    @project = Project.find(params[:id])
  end
end
