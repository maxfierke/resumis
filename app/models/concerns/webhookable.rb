module Webhookable
  extend ActiveSupport::Concern

  included do
    after_commit :trigger_webhook_on_create!, on: :create
    after_commit :trigger_webhook_on_update!, on: :update
    after_commit :trigger_webhook_on_destroy!, on: :destroy
  end

  def trigger_webhook?
    true
  end

  def webhook_triggered?
    false
  end

  private

  def webhook_resource_type
    self.class.name.underscore
  end

  def trigger_webhook_on_create!
    dispatch_webhooks!("#{webhook_resource_type}.created") if trigger_webhook?
  end

  def trigger_webhook_on_update!
    return unless trigger_webhook? || webhook_triggered?
    dispatch_webhooks!("#{webhook_resource_type}.updated")
  end

  def trigger_webhook_on_destroy!
    dispatch_webhooks!("#{webhook_resource_type}.destroyed") if trigger_webhook?
  end

  def dispatch_webhooks!(event_type)
    resource_type = webhook_resource_type
    user.webhooks.enabled.where("? = ANY(resource_types)", resource_type).each do |webhook|
      DispatchWebhookJob.set(good_job_labels: [webhook.id]).perform_later(
        webhook.id,
        event_type: event_type,
        resource_type: resource_type,
        resource_id: id.to_s,
        user_id: user_id.to_s
      )
    end
  end
end
