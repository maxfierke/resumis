class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  layout "application_public", only: [:index, :show]
  respond_to :html, :json

  def index
    @projects = Project.all
    @project_categories = ProjectCategory.all
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.save
    respond_with(@project) do |format|
      format.html { redirect_to projects_path }
    end
  end

  def update
    @project.update(project_params)
    respond_with(@project) do |format|
      format.html { redirect_to projects_path }
    end
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :short_description, :description, :start_date, :end_date, :project_status_id, :github_url)
    end
end
