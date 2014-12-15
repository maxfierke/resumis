class ProjectCategoriesController < ApplicationController
  before_action :set_project_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_current_tenant_session!, only: [:new, :create, :edit, :update, :destroy]


  respond_to :html, :json

  def index
    @project_categories = ProjectCategory.all
    respond_with(@project_categories)
  end

  def show
    respond_with(@project_category)
  end

  def new
    @project_category = ProjectCategory.new
    respond_with(@project_category)
  end

  def edit
  end

  def create
    @project_category = ProjectCategory.new(project_category_params)
    @project_category.save
    respond_with(@project_category)
  end

  def update
    @project_category.update(project_category_params)
    respond_with(@project_category)
  end

  def destroy
    @project_category.destroy
    respond_with(@project_category)
  end

  private
    def set_project_category
      @project_category = ProjectCategory.find(params[:id])
    end

    def project_category_params
      params.require(:project_category).permit(:slug, :name)
    end
end
