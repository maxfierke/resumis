module Manage
  class WorkExperiencesController < ManageController
    before_action :set_work_experience, only: [:edit, :update, :destroy]

    respond_to :html, :json

    def index
      @work_experiences = WorkExperience.page params[:page]
      respond_with(@work_experiences)
    end

    def new
      @work_experience = WorkExperience.new
      respond_with(@work_experience, :location => manage_work_experiences_path)
    end

    def edit
    end

    def create
      @work_experience = WorkExperience.new(work_experience_params)
      @work_experience.user = current_user
      @work_experience.save
      respond_with(@work_experience, :location => manage_work_experiences_path)
    end

    def update
      @work_experience.update(work_experience_params)
      respond_with(@work_experience, :location => manage_work_experiences_path)
    end

    def destroy
      @work_experience.destroy
      respond_with(@work_experience, :location => manage_work_experiences_path)
    end

    private
      def set_work_experience
        @work_experience = WorkExperience.find(params[:id])
      end

      def work_experience_params
        params.require(:work_experience).permit(:organization, :position, :description, :start_date, :end_date)
      end
  end
end
