module Api
  module V1
    class ResumesController < ApiController
      payload_type :resume
      before_action :validate_payload_type, only: [:create, :update]
      before_action only: [:index] do
        doorkeeper_authorize! :public
      end
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :resumes_write
      end

      def index
        authorize Resume
        render jsonapi: resumes, include: include_params
      end

      def show
        authorize resume
        render jsonapi: resume, include: include_params
      end

      def create
        new_resume = Resume.new(resume_params)
        authorize new_resume
        if new_resume.save
          render jsonapi: new_resume, status: :created, location: new_resume
        else
          render_error resource: new_resume
        end
      end

      def update
        authorize resume
        if resume.update_attributes(resume_params)
          render jsonapi: resume
        else
          render_error resource: resume
        end
      end

      def destroy
        authorize resume
        resume.destroy!
        head :no_content
      end

      private

      def allowed_includes
        %w(
          education_experiences
          education_experiences.*
          skills
          skills.*
          work_experiences
          work_experiences.*
        )
      end

      def resume
        @resume ||= policy_scope(Resume).find(params[:id])
      end

      def resumes
        @resumes ||= policy_scope(Resume)
      end

      def resume_params
        ActiveModelSerializers::Deserialization.jsonapi_parse!(
          params, only: [
            :slug, :name, :short_description, :description, :status,
            :categories, :start_date, :end_date
          ]
        ).merge(user: current_resource_owner)
      end
    end
  end
end
