require 'rails_helper'

RSpec.describe Errors::NoTenantSet do
  let(:error) { Errors::NoTenantSet.new }

  describe "#to_json_api" do
    it 'returns a JSON-API compliant errors object' do
      json_errors = error.to_json_api(StubRequest.new)

      expect(json_errors).to eq(
        {
          errors: [
            {
              id: 'uuid123',
              title: 'No Tenant Set',
              detail: "Attempting to access resource for authenticated user when not authenticated.",
              code: 'RESUMIS-NO-TENANT',
              status: '401',
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