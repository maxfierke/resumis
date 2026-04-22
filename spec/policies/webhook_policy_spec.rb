require 'rails_helper'

RSpec.describe WebhookPolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }

  describe 'actions' do
    subject { described_class.new(policy_user, webhook) }

    let(:webhook) { FactoryBot.create(:webhook, user: current_tenant) }

    context 'user is nil' do
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
    end

    context 'user is a browser user' do
      context 'user owns the webhook' do
        let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end

      context "user does not own the webhook" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:policy_user) { PolicyUser.new(other_user, current_tenant) }

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { WebhookPolicy::Scope.new(policy_user, Webhook.all).resolve }

    let(:other_user)  { FactoryBot.create(:user) }
    let!(:my_webhook)    { FactoryBot.create(:webhook, user: current_tenant) }
    let!(:other_webhook) { FactoryBot.create(:webhook, user: other_user) }

    context 'user is the current tenant' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      it 'returns only their own webhooks' do
        expect(subject).to contain_exactly(my_webhook)
      end
    end

    context 'user is a different tenant' do
      let(:policy_user) { PolicyUser.new(other_user, current_tenant) }

      it 'returns webhooks scoped to the current tenant' do
        expect(subject).to contain_exactly(my_webhook)
      end
    end
  end
end
