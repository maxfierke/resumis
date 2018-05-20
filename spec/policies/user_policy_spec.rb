require 'rails_helper'

RSpec.describe UserPolicy do
  let(:current_tenant) { FactoryGirl.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = current_tenant }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, user) }

    context 'user is nil' do
      let(:user) { FactoryGirl.create(:user) }
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions([:edit, :update]) }
    end

    context 'user is an API user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant, doorkeeper_token: access_token) }
      let(:access_token) do
        FactoryGirl.create(
          :access_token,
          resource_owner_id: current_tenant.id,
          scopes: nil
        )
      end
      let(:user) { FactoryGirl.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:current_tenant) { FactoryGirl.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { current_tenant }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }
      let(:user) { FactoryGirl.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:current_tenant) { FactoryGirl.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { current_tenant }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end
  end
end
