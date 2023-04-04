require 'rails_helper'

RSpec.describe SkillCategoryPolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }

  describe 'actions' do
    subject { described_class.new(policy_user, skill_category) }

    context 'user is nil' do
      let(:skill_category) { FactoryBot.create(:skill_category, user: current_tenant) }
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

      context "user doesn't own the skill_category" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:skill_category) do
          FactoryBot.create(:skill_category, user: other_user)
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns skill_category' do
        let(:skill_category) { FactoryBot.create(:skill_category, user: current_tenant) }

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

      context "user doesn't own the skill_category" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:skill_category) do
          FactoryBot.create(:skill_category, user: other_user)
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns skill_category' do
        let(:skill_category) { FactoryBot.create(:skill_category, user: current_tenant) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { SkillCategoryPolicy::Scope.new(policy_user, SkillCategory.all).resolve }
    let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

    it 'returns all skill categories for the user' do
      expect(subject).to match_array(current_tenant.skill_categories)
      expect(subject.size).to eq(CreateUserDefaultsJob::SKILL_CATEGORIES.size)
    end
  end
end
