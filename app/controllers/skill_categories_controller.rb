class SkillCategoriesController < ApplicationController
  before_action :set_skill_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @skill_categories = SkillCategory.all
    respond_with(@skill_categories)
  end

  def show
    respond_with(@skill_category)
  end

  def new
    @skill_category = SkillCategory.new
    respond_with(@skill_category)
  end

  def edit
  end

  def create
    @skill_category = SkillCategory.new(skill_category_params)
    @skill_category.save
    respond_with(@skill_category)
  end

  def update
    @skill_category.update(skill_category_params)
    respond_with(@skill_category)
  end

  def destroy
    @skill_category.destroy
    respond_with(@skill_category)
  end

  private
    def set_skill_category
      @skill_category = SkillCategory.find(params[:id])
    end

    def skill_category_params
      params.require(:skill_category).permit(:name)
    end
end
