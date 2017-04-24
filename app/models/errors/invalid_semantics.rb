module Errors
  class InvalidSemantics < BaseError
    def code
      'RESUMIS-INVALID-SEMANTICS'
    end

    def title
      'Invalid Semantics'
    end

    def detail
      'Request did not align with expected semantics of the resource endpoint and/or method.'
    end

    def http_status_code
      '400'
    end
  end
end
