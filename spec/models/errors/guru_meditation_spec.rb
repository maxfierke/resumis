require 'rails_helper'

RSpec.describe Errors::GuruMeditation do
  let(:error) { Errors::GuruMeditation.new }

  describe "#to_json_api" do
    it 'returns a JSON-API compliant errors object' do
      stub_request = StubRequest.new
      json_errors = error.to_json_api(stub_request)

      expect(json_errors).to eq(
        {
          errors: [
            {
              id: 'uuid123',
              title: 'Fatal Error or Uncaught Exception',
              detail: "An error occurred that Resumis wasn't expecting.",
              code: 'RESUMIS-GURU-MEDITATION',
              status: '500',
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