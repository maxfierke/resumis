class ProjectStatusesController < ApplicationController
  before_action :set_project_status, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @project_statuses = ProjectStatus.all
    respond_with(@project_statuses)
  end

  def show
    respond_with(@project_status)
  end

  def new
    @project_status = ProjectStatus.new
    respond_with(@project_status)
  end

  def edit
  end

  def create
    @project_status = ProjectStatus.new(project_status_params)
    @project_status.save
    respond_with(@project_status)
  end

  def update
    @project_status.update(project_status_params)
    respond_with(@project_status)
  end

  def destroy
    @project_status.destroy
    respond_with(@project_status)
  end

  private
    def set_project_status
      @project_status = ProjectStatus.find(params[:id])
    end

    def project_status_params
      params.require(:project_status).permit(:slug, :name)
    end
end
