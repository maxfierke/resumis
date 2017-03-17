module Api
  module V1
    class ApiController < ActionController::API
      extend ActsAsTenant::ControllerExtensions

      include ResumisConfig
      include TenantHelper

      set_current_tenant_through_filter
      before_action :find_tenant
      before_action :validate_content_type
      
      rescue_from ActsAsTenant::Errors::NoTenantSet, with: :handle_no_tenant_set

      protected

      def handle_no_tenant_set
        render json: { errors: ['No tenant set'] }, status: :unauthorized
      end

      def handle_bad_params
        head :bad_request
      end

      def validate_content_type
        if ['POST','PUT','PATCH'].include?(request.method)
          if request.content_type != "application/vnd.api+json"
            head :not_acceptable
          end
        end
      end

      def validate_payload_type
        if params.dig(:data, :type) == params[:controller]
          return true
        end
        handle_bad_params
      end

      def render_error(resource:, status: :unprocessable_entity)
        render json: resource,
               status: status,
               adapter: :json_api,
               serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end
  end
end
