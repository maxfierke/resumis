module Api
  module V1
    class ApiController < ::Api::BaseController
      DEFAULT_INCLUDES = [].freeze
      DEFAULT_SORTS = [].freeze

      protected

      def allowed_includes
        DEFAULT_INCLUDES
      end

      def allowed_sorts
        DEFAULT_SORTS
      end

      def include_params
        @include_params ||= IncludeParamsValidator.include_params!(
          include_params: params[:include],
          allowed: allowed_includes
        )
      end

      def sort_fields
        @sort_fields ||= SortFieldsParser.parse_params!(
          sort_params: params[:sort],
          allowed: allowed_sorts
        )
      end
    end
  end
end
