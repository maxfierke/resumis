module Api
  module JSONResume
    class ResumesController < ::Api::BaseController
      def show
        render json: resume, serializer: ResumeSerializer
      end

      private

      def resume
        @resume ||= Resume.find(params[:id])
      end
    end
  end
end
