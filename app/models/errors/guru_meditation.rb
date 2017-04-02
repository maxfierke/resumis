module Errors
  class GuruMeditation < BaseError
    def code
      'RESUMIS-GURU-MEDITATION'
    end

    def title
      'Fatal Error or Uncaught Exception'
    end

    def detail
      "An error occurred that Resumis wasn't expecting."
    end
  end
end
