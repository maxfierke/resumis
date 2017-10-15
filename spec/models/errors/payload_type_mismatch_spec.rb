require 'rails_helper'

RSpec.describe Errors::PayloadTypeMismatch do
  let(:error) { Errors::PayloadTypeMismatch.new }

  describe "#to_json_api" do
    it 'returns a JSON-API compliant errors object' do
      json_errors = error.to_json_api(StubRequest.new)

      expect(json_errors).to eq(
        {
          errors: [
            {
              id: 'uuid123',
              title: 'Payload Type Mismatch',
              detail: "JSON-API payload 'type' does not match the type of the resource",
              code: 'RESUMIS-PAYLOAD-TYPE-MISMATCH',
              status: '400',
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