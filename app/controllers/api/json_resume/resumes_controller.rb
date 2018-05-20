module Api
  module JsonResume
    class ResumesController < ::Api::BaseController
      def show
        authorize resume
        render json: resume, serializer: ResumeSerializer, adapter: :attributes
      end

      private

      def resume
        @resume ||= policy_scope(Resume).find(params[:id])
      end
    end
  end
end
