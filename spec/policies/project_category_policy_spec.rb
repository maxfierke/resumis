require 'rails_helper'

RSpec.describe ProjectCategoryPolicy do
  let(:user) { FactoryGirl.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = user }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, project_category) }

    context 'user is nil' do
      let(:project_category) { FactoryGirl.create(:project_category) }
      let(:policy_user) { PolicyUser.new(nil) }

      it { is_expected.to permit_actions([:index, :show]) }
      it { is_expected.to forbid_actions([:create, :update, :destroy]) }
    end

    context 'user is an API user' do
      let(:access_token) do
        FactoryGirl.create(
          :access_token,
          resource_owner_id: user.id,
          scopes: nil
        )
      end
      let(:policy_user) { PolicyUser.new(user, doorkeeper_token: access_token) }

      context "user doesn't own the project category" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:project_category) do
          ActsAsTenant.without_tenant do
            FactoryGirl.create(:project_category, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns project category' do
        let(:project_category) { FactoryGirl.create(:project_category) }

        context "token doesn't have projects_write scope" do
          it { is_expected.to permit_actions([:index, :show]) }
          it { is_expected.to forbid_actions([:create, :update, :destroy]) }
        end

        context 'token has projects_write scope' do
          let(:access_token) do
            FactoryGirl.create(
              :access_token,
              resource_owner_id: user.id,
              scopes: 'projects_write'
            )
          end

          it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
        end
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(user) }

      context "user doesn't own the project category" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:project_category) do
          ActsAsTenant.without_tenant do
            FactoryGirl.create(:project_category, user: other_user)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns project category' do
        let(:project_category) { FactoryGirl.create(:project_category) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { ProjectCategoryPolicy::Scope.new(policy_user, ProjectCategory.all).resolve }

    let!(:project_categories) { FactoryGirl.create_list(:project_category, 3) }
    let(:policy_user) { PolicyUser.new(user) }

    it 'returns all project categories for the user' do
      expect(subject).to match_array(project_categories)
    end
  end
end
