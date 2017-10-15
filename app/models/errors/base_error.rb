module Errors
  class BaseError
    attr_reader :exception

    def initialize(exception = nil)
      @exception = exception
    end

    def title
      raise 'Must be implemented by subclass'
    end

    def code
      raise 'Must be implemented by subclass'
    end

    def detail
      ''
    end

    def http_status_code
      '500'
    end

    def to_json_api(request)
      {
        errors: [
          {
            id: request.uuid,
            meta: {
              request_uuid: request.uuid,
              content_type: request.content_type || request.headers['Accept'],
              api_version: request.headers['X-Resumis-Version']
            }
          }.merge(to_h)
        ]
      }
    end

    def to_h
      {
        title: title,
        detail: detail,
        code: code,
        status: http_status_code.to_s,
      }
    end
  end
end
