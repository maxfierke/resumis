module Api
  module V1
    class UsersController < ApiController
      include ActiveStorage::SetCurrent

      ALLOWED_INCLUDES = [
        'projects', 'projects.*',
        'skills', 'skills.*'
      ]

      def show
        authorize user
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
        @user ||= begin
          scope = policy_scope(User)

          if include_params.include?('projects.*')
            scope = scope.includes(projects: [:project_categories, :project_status])
          elsif include_params.include?('projects')
            scope = scope.includes(:projects)
          end

          if include_params.include?('skills.*')
            scope = scope.includes(skills: [:skill_category])
          elsif include_params.include?('skills')
            scope = scope.includes(:skills)
          end

          scope.find(params[:id])
        end
      end
    end
  end
end
