module Api
  module V1
    class ResumesController < ApiController
      ALLOWED_INCLUDES = [
        'education_experiences', 'education_experiences.*',
        'skills', 'skills.*',
        'work_experiences', 'work_experiences.*'
      ]

      payload_type :resume
      before_action :validate_payload_type, only: [:create, :update]
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :resumes_write
      end

      def index
        render jsonapi: resumes, include: include_params
      end

      def show
        render jsonapi: resume, include: include_params
      end

      def create
        new_resume = Resume.new(resume_params)
        if new_resume.save
          render jsonapi: new_resume, status: :created, location: new_resume
        else
          render_error resource: new_resume
        end
      end

      def update
        resume.update_attributes(resume_params)
        if resume.save
          render jsonapi: resume
        else
          render_error resource: resume
        end
      end

      def destroy
        resume.destroy!
        head :no_content
      end

      private

      def include_params
        @include_params ||= IncludeParamsValidator.include_params!(
          include_params: params[:include],
          allowed: ALLOWED_INCLUDES
        )
      end

      def resume
        @resume ||= Resume.find(params[:id])
      end

      def resumes
        @resumes ||= Resume.all
      end

      def resume_params
        ActiveModelSerializers::Deserialization.jsonapi_parse!(
          params, only: [
            :slug, :name, :short_description, :description, :status,
            :categories, :start_date, :end_date
          ]
        ).merge(user: current_tenant)
      end
    end
  end
end
