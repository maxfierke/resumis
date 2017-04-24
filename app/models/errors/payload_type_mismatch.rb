module Errors
  class PayloadTypeMismatch < BaseError
    def code
      'RESUMIS-PAYLOAD-TYPE-MISMATCH'
    end

    def title
      'Payload Type Mismatch'
    end

    def detail
      "JSON-API payload 'type' does not match the type of the resource"
    end

    def http_status_code
      '400'
    end
  end
end
