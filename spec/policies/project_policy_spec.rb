require 'rails_helper'

RSpec.describe ProjectPolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = current_tenant }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, project) }

    context 'user is nil' do
      let(:project) { FactoryBot.create(:project) }
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to permit_actions([:index, :show]) }
      it { is_expected.to forbid_actions([:create, :update, :destroy]) }
    end

    context 'user is an API user' do
      let(:access_token) do
        FactoryBot.create(
          :access_token,
          resource_owner_id: current_tenant.id,
          scopes: nil
        )
      end
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant, doorkeeper_token: access_token) }

      context "user doesn't own the project" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:project) do
          ActsAsTenant.without_tenant do
            FactoryBot.create(:project, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns project' do
        let(:project) { FactoryBot.create(:project) }

        context "token doesn't have projects_write scope" do
          it { is_expected.to permit_actions([:index, :show]) }
          it { is_expected.to forbid_actions([:create, :update, :destroy]) }
        end

        context 'token has projects_write scope' do
          let(:access_token) do
            FactoryBot.create(
              :access_token,
              resource_owner_id: current_tenant.id,
              scopes: 'projects_write'
            )
          end

          it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
        end
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      context "user doesn't own the project" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:project) do
          ActsAsTenant.without_tenant do
            FactoryBot.create(:project, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns project' do
        let(:project) { FactoryBot.create(:project) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { ProjectPolicy::Scope.new(policy_user, Project.all).resolve }

    let!(:projects) { FactoryBot.create_list(:project, 3) }
    let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

    it 'returns all projects for the user' do
      expect(subject).to match_array(projects)
    end
  end
end
