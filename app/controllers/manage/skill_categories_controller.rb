module Manage
  class SkillCategoriesController < ManageController
    before_action :set_skill_category, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @skill_categories = policy_scope(SkillCategory).page params[:page]

      respond_to do |format|
        format.html { redirect_to manage_skills_path }
        format.json
      end
    end

    def new
      @skill_category = SkillCategory.new
      authorize @skill_category
      respond_with(@skill_category)
    end

    def edit
    end

    def create
      @skill_category = SkillCategory.new(skill_category_params)
      authorize @skill_category
      respond_to do |format|
        if @skill_category.save
          format.html { redirect_to manage_skills_path, notice: "#{@skill_category.name} was successfully created." }
          format.json { render :show, status: :ok, location: manage_skills_path }
        else
          format.html { render :edit }
          format.json { render json: @skill_category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @skill_category.update(skill_category_params)
          format.html { redirect_to manage_skills_path, notice: "#{@skill_category.name} was successfully updated." }
          format.json { render :show, status: :ok, location: manage_skills_path }
        else
          format.html { render :edit }
          format.json { render json: @skill_category.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @skill_category.destroy
          format.html { redirect_to manage_skills_path, notice: "#{@skill_category.name} was successfully destroyed." }
          format.json { render :show, status: :ok, location: manage_skills_path }
        else
          format.html { redirect_to manage_skills_path, notice: "Category could not be destroyed." }
          format.json { render json: nil, status: :unprocessable_entity }
        end
      end
    end

    private
      def set_skill_category
        @skill_category = policy_scope(SkillCategory).find(params[:id])
        authorize @skill_category
      end

      def skill_category_params
        params.require(:skill_category).permit(:name).merge!(user: current_user)
      end
  end
end
