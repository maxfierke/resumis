module Errors
  class NoTenantSet < BaseError
    def code
      'RESUMIS-NO-TENANT'
    end

    def title
      'No Tenant Set'
    end

    def detail
      'Attempting to access resource for authenticated user when not authenticated.'
    end

    def http_status_code
      '401'
    end
  end
end
