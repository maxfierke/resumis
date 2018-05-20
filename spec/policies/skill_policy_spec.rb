require 'rails_helper'

RSpec.describe SkillPolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = current_tenant }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, skill) }

    context 'user is nil' do
      let(:skill) { FactoryBot.create(:skill) }
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

      context "user doesn't own the skill" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:skill) do
          ActsAsTenant.without_tenant do
            FactoryBot.create(:skill, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns skill' do
        let(:skill) { FactoryBot.create(:skill) }

        context "token doesn't have resumes_write scope" do
          it { is_expected.to permit_actions([:index, :show]) }
          it { is_expected.to forbid_actions([:create, :update, :destroy]) }
        end

        context 'token has resumes_write scope' do
          let(:access_token) do
            FactoryBot.create(
              :access_token,
              resource_owner_id: current_tenant.id,
              scopes: 'resumes_write'
            )
          end

          it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
        end
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      context "user doesn't own the skill" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:skill) do
          ActsAsTenant.without_tenant do
            FactoryBot.create(:skill, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns skill' do
        let(:skill) { FactoryBot.create(:skill) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { SkillPolicy::Scope.new(policy_user, Skill.all).resolve }

    let!(:skills) { FactoryBot.create_list(:skill, 3) }
    let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

    it 'returns all skills for the user' do
      expect(subject).to match_array(skills)
    end
  end
end
