module Api
  class BaseController < ActionController::API
    extend ActsAsTenant::ControllerExtensions

    include ActionController::Helpers
    include Pundit
    include ResumisConfig
    include TenantHelper

    set_current_tenant_through_filter
    before_action :find_tenant
    before_action :validate_content_type

    rescue_from StandardError, with: :handle_exception

    protected

    def self.payload_type(payload_type)
      @@payload_type = payload_type.to_s
    end

    def current_resource_owner
      return nil unless doorkeeper_token
      @current_resource_owner ||= if doorkeeper_token.resource_owner_id
        User.find(doorkeeper_token.resource_owner_id)
      elsif doorkeeper_token.application
        User.find(doorkeeper_token.application.owner_id)
      end
    end

    def pundit_user
      PolicyUser.new(current_resource_owner, doorkeeper_token: doorkeeper_token)
    end

    def validate_content_type
      if ['POST','PUT','PATCH'].include?(request.method)
        if request.content_type != "application/vnd.api+json"
          head :not_acceptable
        end
      end
    end

    def validate_payload_type
      unless params[:data].respond_to?(:keys) && params.dig(:data, :type) == @@payload_type
        raise PayloadTypeMismatch
      end
    end

    def render_error(resource:, status: :unprocessable_entity)
      render json: resource,
              status: status,
              adapter: :json_api,
              serializer: ActiveModel::Serializer::ErrorSerializer
    end

    def handle_exception(exception)
      raise exception if Rails.env.development?
      Rails.logger.error exception.message
      Rails.logger.error exception.backtrace.join("\n")
      error = Errors::Resolver.resolve_for(exception)
      render status: error.http_status_code.to_i, json: error.to_json_api(request)
    end
  end
end
