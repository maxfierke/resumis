class WorkExperiencesController < ApplicationController
  before_action :set_work_experience, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @work_experiences = WorkExperience.all
    respond_with(@work_experiences)
  end

  def show
    respond_with(@work_experience)
  end

  def new
    @work_experience = WorkExperience.new
    respond_with(@work_experience)
  end

  def edit
  end

  def create
    @work_experience = WorkExperience.new(work_experience_params)
    @work_experience.user = current_user
    @work_experience.save
    respond_with(@work_experience)
  end

  def update
    @work_experience.update(work_experience_params)
    respond_with(@work_experience)
  end

  def destroy
    @work_experience.destroy
    respond_with(@work_experience)
  end

  private
    def set_work_experience
      @work_experience = WorkExperience.find(params[:id])
    end

    def work_experience_params
      params.require(:work_experience).permit(:organization, :description, :start_date, :end_date)
    end
end
