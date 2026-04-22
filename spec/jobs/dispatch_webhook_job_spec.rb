require 'rails_helper'

RSpec.describe DispatchWebhookJob, type: :job do
  let(:user)    { FactoryBot.create(:user) }
  let(:webhook) { FactoryBot.create(:webhook, user: user) }

  let(:event_params) do
    {
      event_type:    "post.updated",
      resource_type: "post",
      resource_id:   "867530989",
      user_id:       user.id.to_s
    }
  end

  def stub_faraday(webhook, status: 200)
    stubs = Faraday::Adapter::Test::Stubs.new
    conn  = Faraday.new(url: webhook.url) { |f| f.adapter(:test, stubs) }
    allow(Faraday).to receive(:new).and_return(conn)
    stubs
  end

  describe '#perform' do
    context 'when the webhook exists and is enabled' do
      it 'POSTs the payload to the webhook URL' do
        request_made = false
        stubs = stub_faraday(webhook)
        stubs.post('/hooks/deploy') do
          request_made = true
          [200, {}, 'yay']
        end

        DispatchWebhookJob.perform_now(webhook.id, **event_params)

        expect(request_made).to be(true)
      end

      it 'sends a JSON:API payload with the correct attributes' do
        received_body = nil
        stubs = stub_faraday(webhook)
        stubs.post('/hooks/deploy') do |env|
          received_body = JSON.parse(env.body)
          [200, {}, 'yay']
        end

        DispatchWebhookJob.perform_now(webhook.id, **event_params)

        expect(received_body.dig("data", "type")).to eq("webhook_events")
        expect(received_body.dig("data", "attributes", "event_type")).to eq("post.updated")
        expect(received_body.dig("data", "attributes", "resource_type")).to eq("post")
        expect(received_body.dig("data", "attributes", "resource_id")).to eq("867530989")
        expect(received_body.dig("data", "attributes", "user_id")).to eq(user.id.to_s)
      end

      it 'sends a Content-Type header of application/vnd.api+json' do
        received_headers = nil
        stubs = stub_faraday(webhook)
        stubs.post('/hooks/deploy') do |env|
          received_headers = env.request_headers
          [200, {}, 'yay']
        end

        DispatchWebhookJob.perform_now(webhook.id, **event_params)

        expect(received_headers["Content-Type"]).to eq("application/vnd.api+json")
      end

      it 'sends a valid HMAC signature header' do
        received_headers = nil
        received_body    = nil
        stubs = stub_faraday(webhook)
        stubs.post('/hooks/deploy') do |env|
          received_headers = env.request_headers
          received_body    = env.body
          [200, {}, 'yay']
        end

        DispatchWebhookJob.perform_now(webhook.id, **event_params)

        expected_sig = "sha256=#{OpenSSL::HMAC.hexdigest('SHA256', webhook.secret, received_body)}"
        expect(received_headers["X-Resumis-Signature"]).to eq(expected_sig)
      end

      it 'raises on a non-2xx response' do
        stubs = stub_faraday(webhook, status: 500)
        stubs.post('/hooks/deploy') do
          [500, {}, 'Internal Server Error']
        end

        expect {
          DispatchWebhookJob.perform_now(webhook.id, **event_params)
        }.to raise_error(RuntimeError, /500/)
      end
    end

    context 'when the webhook is disabled' do
      let(:webhook) { FactoryBot.create(:webhook, :disabled, user: user) }

      it 'does not make any HTTP request' do
        allow(Faraday).to receive(:new)

        DispatchWebhookJob.perform_now(webhook.id, **event_params)

        expect(Faraday).not_to have_received(:new)
      end
    end

    context 'when the webhook no longer exists' do
      it 'does not make any HTTP request' do
        allow(Faraday).to receive(:new)

        DispatchWebhookJob.perform_now(0, **event_params)

        expect(Faraday).not_to have_received(:new)
      end
    end
  end
end
