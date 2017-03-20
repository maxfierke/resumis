module Api
  module V1
    class UsersController < ApiController
      def show
        render jsonapi: user, include: include_params
      end

      private

      def include_params
        @include_params ||= begin
          assocs = if params[:include].is_a?(String)
            params[:include].split(',')
          else
            params[:include] || []
          end
          assocs.select { |a| a =~ /^(projects)/ }
        end
      end

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
