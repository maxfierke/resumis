module Api
  module V1
    class UsersController < ApiController
      include ActiveStorage::SetCurrent

      def show
        authorize user
        render jsonapi: user, include: include_params
      end

      private

      def allowed_includes
        %w(
          projects
          projects.*
          skills
          skills.*
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

          scope.
            with_attached_avatar_image.
            with_attached_header_image.
            find(params[:id])
        end
      end
    end
  end
end
