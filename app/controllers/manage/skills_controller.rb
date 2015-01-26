module Manage
  class SkillsController < ManageController
    before_action :set_skill_category, only: [:edit, :update, :destroy]
    before_action :set_skill, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @skills_with_cat = SkillCategory.all
      respond_with(@skills)
    end

    def new
      @skill = Skill.new
      @skill.skill_category_id = params[:skill_category_id]
      respond_with(@skill)
    end

    def edit
    end

    def create
      @skill = Skill.new(skill_params)
      @skill.user = current_user
      respond_to do |format|
        if @skill.save
          format.html { redirect_to skills_path, notice: "#{@skill.name} was successfully created." }
          format.json
        else
          format.html { render :new }
          format.json
        end
      end
    end

    def update
      respond_to do |format|
        if @skill.update(skill_params)
          format.html { redirect_to skills_path, notice: "#{@skill.name} was successfully updated." }
          format.json
        else
          format.html { render :edit }
          format.json
        end
      end
    end

    def destroy
      @skill.destroy
      respond_with(@skill)
    end

    private
      def set_skill_category
        @skill_category = SkillCategory.find(params[:skill_category_id])
      end

      def set_skill
        @skill = Skill.find(params[:id])
      end

      def skill_params
        params.require(:skill).permit(:name, :skill_category_id)
      end
  end
end
