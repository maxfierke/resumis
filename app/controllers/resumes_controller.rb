class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :require_current_tenant_session!, only: [:index, :new, :create, :edit, :update, :destroy]
  layout "resume", only: [:show]
  respond_to :html, :json

  def index
    @resumes = Resume.all
    respond_with(@resumes)
  end

  def show
    # Only allow viewing of published resumes, or resumes a user owns
    if not @resume.published and (!user_signed_in? or current_user.id != @resume.user.id)
      return head :forbidden
    end

    @skills_by_cat = SkillCategory.with_skills

    if stale?(@resume, public: true)
      respond_to do |format|
        format.html
        format.json
        format.md
        format.pdf do
          render :pdf           => @resume.name,
                 :layout        => 'resume',
                 :disable_smart_shrinking => true,
                 :page_size     => 'Letter'
        end
      end
    end
  end

  def new
    @resume = Resume.new
    respond_with(@resume)
  end

  def edit
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    @resume.save
    respond_with(@resume)
  end

  def update
    @resume.update(resume_params)
    respond_with(@resume)
  end

  def destroy
    @resume.destroy
    respond_with(@resume)
  end

  private
    def set_resume
      @resume = Resume.find(params[:id])
    end

    def resume_params
      params.require(:resume).permit(:debug, :name, :description, :background, :published, education_experience_ids: [], project_ids: [], skill_ids: [], work_experience_ids: [])
    end
end
