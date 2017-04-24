module Api
  module JsonResume
    class ResumesController < ::Api::BaseController
      def show
        render json: resume, serializer: ResumeSerializer, adapter: :attributes
      end

      private

      def resume
        @resume ||= Resume.find(params[:id])
      end
    end
  end
end
