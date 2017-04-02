require 'rails_helper'

RSpec.describe Errors::InvalidSemantics do
  let(:error) { Errors::InvalidSemantics.new }

  describe "#to_json_api" do
    it 'returns a JSON-API compliant errors object' do
      json_errors = error.to_json_api(StubRequest.new)

      expect(json_errors).to eq(
        {
          errors: {
            id: 'uuid123',
            title: 'Invalid Semantics',
            detail: "Request did not align with expected semantics of the resource endpoint and/or method.",
            code: 'RESUMIS-INVALID-SEMANTICS',
            status: '400',
            meta: {
              request_uuid: 'uuid123',
              content_type: 'application/vnd.api+json',
              api_version: 'v1'
            }
          }
        }
      )
    end
  end
end