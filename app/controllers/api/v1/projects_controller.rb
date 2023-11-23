module Api
  module V1
    class ProjectsController < ApiController
      payload_type :project
      before_action :validate_payload_type, only: [:create, :update]
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :projects_write
      end

      def index
        render jsonapi: projects, include: include_params
      end

      def show
        render jsonapi: project, include: include_params
      end

      def create
        new_project = Project.new(project_params)
        authorize new_project
        if new_project.save
          render jsonapi: new_project, status: :created, location: new_project
        else
          render_error resource: new_project
        end
      end

      def update
        authorize project
        if project.update_attributes(project_params)
          render jsonapi: project
        else
          render_error resource: project
        end
      end

      def destroy
        authorize project
        project.destroy!
        head :no_content
      end

      private

      def allowed_includes
        %w(categories status)
      end

      def allowed_sorts
        %w(end_date featured name start_date)
      end

      def project
        @project ||= policy_scope(Project).find(params[:id])
      end

      def projects
        @projects ||= begin
          scope = policy_scope(Project)

          if include_params.include?('categories')
            scope = scope.includes(:project_categories)
          end

          if include_params.include?('status')
            scope = scope.includes(:project_status)
          end

          if sort_fields.any?
            sort_fields.each do |field, direction|
              if field == :end_date && direction == :desc
                # A null end_date is considered "on-going", so we want it on top
                scope = scope.order(Project.arel_table[field].desc.nulls_first)
              else
                scope = scope.order(field => direction)
              end
            end
          else
            scope = scope.ordered_by_activity
          end

          scope
        end
      end

      def project_params
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
