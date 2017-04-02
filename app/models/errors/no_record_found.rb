module Errors
  class NoRecordFound < BaseError
    def code
      'RESUMIS-NO-RECORD'
    end

    def title
      'Not Found'
    end

    def detail
      'The requested resource could not be found. It may have never existed or may have been removed.'
    end

    def http_status_code
      '404'
    end
  end
end
