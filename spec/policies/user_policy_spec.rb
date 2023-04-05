require 'rails_helper'

RSpec.describe UserPolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }

  describe 'actions' do
    subject { described_class.new(policy_user, user) }

    context 'user is nil' do
      let(:user) { FactoryBot.create(:user) }
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions([:edit, :update]) }
    end

    context 'user is an API user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant, doorkeeper_token: access_token) }
      let(:access_token) do
        FactoryBot.create(
          :access_token,
          resource_owner_id: current_tenant.id,
          scopes: nil
        )
      end
      let(:user) { FactoryBot.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:current_tenant) { FactoryBot.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { current_tenant }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }
      let(:user) { FactoryBot.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:current_tenant) { FactoryBot.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { current_tenant }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end
  end

  describe 'scope' do
    subject { UserPolicy::Scope.new(policy_user, User.all).resolve }

    context 'user is nil' do
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it 'returns only the current tenant' do
        expect(subject).to match_array([current_tenant])
      end
    end

    context 'user is not the current tenant' do
      let(:current_user) { FactoryBot.create(:user, admin: false) }
      let(:policy_user) { PolicyUser.new(current_user, current_tenant) }

      it 'returns only the current user' do
        expect(subject).to match_array([current_user])
      end

      context 'user has been disabled' do
        let(:current_user) { FactoryBot.create(:user, :disabled, admin: false) }

        it 'does not return any users' do
          expect(subject).to match_array([])
        end
      end
    end

    context 'user is current_tenant' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      it 'returns only the current_tenant' do
        expect(subject).to match_array([current_tenant])
      end
    end
  end
end
