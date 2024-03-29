module Api
  class BaseController < ActionController::API
    include ActionController::Helpers
    include Pundit::Authorization
    include ResumisConfig
    include TenantHelper

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
      PolicyUser.new(
        current_resource_owner,
        current_tenant,
        doorkeeper_token: doorkeeper_token
      )
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
      defined?(Sentry) && Sentry.capture_exception(exception)
      Rails.logger.error exception.message
      Rails.logger.error exception.backtrace.join("\n")
      error = Errors::Resolver.resolve_for(exception)
      render status: error.http_status_code.to_i, json: error.to_json_api(request)
    end

    private

    def meta(collection, options = {})
      meta_resp = super

      meta_resp[:pagination][:first] = { page: 1 }
      meta_resp[:pagination][:last] = { page: collection.total_pages }

      unless collection.first_page?
        meta_resp[:pagination][:prev] = {
          page: collection.current_page - 1,
        }
      end

      unless collection.last_page? || collection.current_page >= collection.total_pages
        meta_resp[:pagination][:next] = {
          page: collection.current_page + 1
        }
      end

      meta_resp
    end
  end
end
