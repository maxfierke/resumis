class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @skills = Skill.all
    respond_with(@skills)
  end

  def show
    respond_with(@skill)
  end

  def new
    @skill = Skill.new
    respond_with(@skill)
  end

  def edit
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    @skill.save
    respond_with(@skill)
  end

  def update
    @skill.update(skill_params)
    respond_with(@skill)
  end

  def destroy
    @skill.destroy
    respond_with(@skill)
  end

  private
    def set_skill
      @skill = Skill.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :skill_category_id, :user_id)
    end
end
