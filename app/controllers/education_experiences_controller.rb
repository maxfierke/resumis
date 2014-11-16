class EducationExperiencesController < ApplicationController
  before_action :set_education_experience, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @education_experiences = EducationExperience.all
    respond_with(@education_experiences)
  end

  def show
    respond_with(@education_experience)
  end

  def new
    @education_experience = EducationExperience.new
    respond_with(@education_experience)
  end

  def edit
  end

  def create
    @education_experience = EducationExperience.new(education_experience_params)
    @education_experience.user = current_user
    @education_experience.save
    respond_with(@education_experience)
  end

  def update
    @education_experience.update(education_experience_params)
    respond_with(@education_experience)
  end

  def destroy
    @education_experience.destroy
    respond_with(@education_experience)
  end

  private
    def set_education_experience
      @education_experience = EducationExperience.find(params[:id])
    end

    def education_experience_params
      params.require(:education_experience).permit(:school_name, :description, :start_date, :end_date)
    end
end
