module Errors
  class Forbidden < BaseError
    def code
      'RESUMIS-FORBIDDEN'
    end

    def title
      'Forbidden'
    end

    def detail
      "You're not allowed to access this resource."
    end

    def http_status_code
      '403'
    end
  end
end
