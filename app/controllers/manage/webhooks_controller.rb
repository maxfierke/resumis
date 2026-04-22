module Manage
  class WebhooksController < ManageController
    before_action :set_webhook, only: [:show, :edit, :update, :destroy]

    def index
      @webhooks = policy_scope(Webhook).page(params[:page])
    end

    def show
    end

    def new
      @webhook = Webhook.new(user: current_user)
      authorize @webhook
    end

    def edit
    end

    def create
      @webhook = Webhook.new(webhook_params)
      authorize @webhook

      respond_to do |format|
        if @webhook.save
          format.html { redirect_to manage_webhooks_path, notice: "Webhook was successfully created." }
        else
          format.html { render :new }
        end
      end
    end

    def update
      respond_to do |format|
        if @webhook.update(webhook_params)
          format.html { redirect_to manage_webhooks_path, notice: "Webhook was successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @webhook.destroy!
      respond_to do |format|
        format.html { redirect_to manage_webhooks_path, notice: "Webhook was successfully destroyed." }
      end
    end

    private

    def set_webhook
      @webhook = policy_scope(Webhook).find(params[:id])
      authorize @webhook
    end

    def webhook_params
      params.require(:webhook).permit(
        :name,
        :url,
        :enabled,
        resource_types: [],
      ).merge!(user: current_user)
    end
  end
end
