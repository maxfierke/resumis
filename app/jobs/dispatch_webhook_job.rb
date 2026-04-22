class DispatchWebhookJob < ApplicationJob
  include GoodJob::ActiveJobExtensions::Concurrency

  queue_as :webhooks

  good_job_concurrency_rule(
    label: -> { arguments.first },
    total_limit: 1,
  )

  retry_on Faraday::ConnectionFailed, Faraday::TimeoutError,
           wait: :polynomially_longer
  discard_on ActiveJob::DeserializationError

  def perform(webhook_id, event_type:, resource_type:, resource_id:, user_id:)
    webhook = Webhook.find_by(id: webhook_id)
    return unless webhook&.enabled?

    payload_body = build_payload(
      event_type,
      resource_type,
      resource_id,
      user_id,
    ).to_json
    signature = OpenSSL::HMAC.hexdigest("SHA256", webhook.secret, payload_body)

    conn = Faraday.new(
      url: webhook.url,
      request: {
        timeout: 10,
        open_timeout: 10,
      },
    )

    response = conn.post do |req|
      req.headers["Content-Type"]        = "application/vnd.api+json"
      req.headers["User-Agent"]          = "Resumis-Webhook/1.0"
      req.headers["X-Resumis-Signature"] = "sha256=#{signature}"
      req.body = payload_body
    end

    unless response.success?
      raise "Webhook delivery failed with HTTP #{response.status}"
    end
  end

  private

  def build_payload(event_type, resource_type, resource_id, user_id)
    {
      data: {
        type: "webhook_events",
        attributes: {
          event_type:    event_type,
          resource_type: resource_type,
          resource_id:   resource_id,
          user_id:       user_id,
          occurred_at:   Time.current.iso8601
        }
      }
    }
  end
end
