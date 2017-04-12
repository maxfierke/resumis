module Api
  module V1
    class UsersController < ApiController
      ALLOWED_INCLUDES = [
        'projects', 'projects.*'
      ]

      before_action only: [:show] do
        doorkeeper_authorize! :public
      end

      def show
        render jsonapi: user, include: include_params
      end

      private

      def include_params
        @include_params ||= IncludeParamsValidator.include_params!(
          include_params: params[:include],
          allowed: ALLOWED_INCLUDES
        )
      end

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
