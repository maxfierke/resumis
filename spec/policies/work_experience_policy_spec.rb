require 'rails_helper'

RSpec.describe WorkExperiencePolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }
  let(:work_experience) do
    FactoryBot.create(:work_experience, resumes: [resume], user: resume.user)
  end

  describe 'actions' do
    subject { described_class.new(policy_user, work_experience) }

    context 'user is nil' do
      let(:resume) { FactoryBot.create(:resume, user: current_tenant) }
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }

      context 'resume is published' do
        let!(:resume) { FactoryBot.create(:resume, published: true, user: current_tenant) }

        it { is_expected.to permit_action(:show) }
      end
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

      context "user doesn't own the resume" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:resume) do
          FactoryBot.create(:resume, user: other_user, published: true)
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns resume' do
        let!(:resume) { FactoryBot.create(:resume, user: current_tenant) }

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

      context "user doesn't own the resume" do
        let(:other_user) { FactoryBot.create(:user) }
        let(:resume) do
          FactoryBot.create(:resume, user: other_user, published: true)
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns resume' do
        let!(:resume) { FactoryBot.create(:resume, user: current_tenant) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject do
      WorkExperiencePolicy::Scope.new(
        policy_user,
        WorkExperience.all
      ).resolve
    end

    let!(:secret_resume) { FactoryBot.create(:resume, published: false, user: current_tenant) }
    let!(:secret_experiences) do
      FactoryBot.create_list(:work_experience, 5, resumes: [
        secret_resume
      ], user: current_tenant)
    end
    let!(:published_resume) { FactoryBot.create(:resume, published: true, user: current_tenant) }
    let!(:published_experiences) do
      FactoryBot.create_list(:work_experience, 5, resumes: [
        published_resume
      ], user: current_tenant)
    end

    context 'user is nil' do
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it 'returns only published resumes' do
        expect(subject).to match_array(published_experiences)
      end
    end

    context 'user is not the current tenant' do
      let(:policy_user) { PolicyUser.new(FactoryBot.create(:user, admin: false), current_tenant) }

      it 'returns only published resumes' do
        expect(subject).to match_array(published_experiences)
      end
    end

    context 'user is current_tenant' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      it 'returns all resumes for the current_tenant' do
        expect(subject).to match_array(secret_experiences + published_experiences)
      end
    end
  end
end
