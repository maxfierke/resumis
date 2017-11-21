require 'rails_helper'

RSpec.describe UserPolicy do
  let(:test_user) { FactoryGirl.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = test_user }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, user) }

    context 'user is nil' do
      let(:user) { FactoryGirl.create(:user) }
      let(:policy_user) { PolicyUser.new(nil) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions([:edit, :update]) }
    end

    context 'user is an API user' do
      let(:policy_user) { PolicyUser.new(test_user, doorkeeper_token: access_token) }
      let(:access_token) do
        FactoryGirl.create(
          :access_token,
          resource_owner_id: test_user.id,
          scopes: nil
        )
      end
      let(:user) { FactoryGirl.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:test_user) { FactoryGirl.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { test_user }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(test_user) }
      let(:user) { FactoryGirl.create(:user) }

      it { is_expected.to permit_actions([:show]) }
      it { is_expected.to forbid_actions([:edit, :update]) }

      context 'user is admin' do
        let(:test_user) { FactoryGirl.create(:user, admin: true) }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end

      context 'authenticated user is the same as the user resource' do
        let(:user) { test_user }

        it { is_expected.to permit_actions([:show, :edit, :update]) }
      end
    end
  end
end
