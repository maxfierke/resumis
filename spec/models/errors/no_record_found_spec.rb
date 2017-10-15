require 'rails_helper'

RSpec.describe Errors::NoRecordFound do
  let(:error) { Errors::NoRecordFound.new }

  describe "#to_json_api" do
    it 'returns a JSON-API compliant errors object' do
      json_errors = error.to_json_api(StubRequest.new)

      expect(json_errors).to eq(
        {
          errors: [
            {
              id: 'uuid123',
              title: 'Not Found',
              detail: "The requested resource could not be found. It may have never existed or may have been removed.",
              code: 'RESUMIS-NO-RECORD',
              status: '404',
              meta: {
                request_uuid: 'uuid123',
                content_type: 'application/vnd.api+json',
                api_version: 'v1'
              }
            }
          ]
        }
      )
    end
  end
end