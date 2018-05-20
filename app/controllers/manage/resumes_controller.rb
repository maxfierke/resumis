module Manage
  class ResumesController < ManageController
    before_action :set_resume, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @resumes = policy_scope(Resume).page params[:page]
      respond_with(@resumes)
    end

    def new
      @resume = Resume.new
      authorize @resume
      respond_with(@resume)
    end

    def edit
    end

    def create
      @resume = Resume.new(resume_params)
      authorize @resume
      @resume.save
      respond_with(@resume)
    end

    def update
      @resume.update(resume_params)
      respond_with(@resume, :location => edit_manage_resume_path(@resume))
    end

    def destroy
      @resume.destroy
      respond_with(@resume, :location => manage_resumes_path)
    end

    private
      def set_resume
        @resume = policy_scope(Resume).find(params[:id])
        authorize @resume
      end

      def resume_params
        params.require(:resume).permit(
          :name,
          :description,
          :background,
          :published,
          education_experience_ids: [],
          project_ids: [],
          skill_ids: [],
          work_experience_ids: []
        ).merge!(user: current_user)
      end
  end
end
