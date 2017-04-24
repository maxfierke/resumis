module Api
  class BaseController < ActionController::API
    extend ActsAsTenant::ControllerExtensions

    include ActionController::Helpers
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
      error = Errors::Resolver.resolve_for(exception)
      render status: error.http_status_code.to_i, json: error.to_json_api
    end
  end
end
