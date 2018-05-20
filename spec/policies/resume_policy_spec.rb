require 'rails_helper'

RSpec.describe ResumePolicy do
  let(:current_tenant) { FactoryBot.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = current_tenant }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, resume) }

    context 'user is nil' do
      let(:resume) { FactoryBot.create(:resume) }
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }

      context 'resume is published' do
        let(:resume) { FactoryBot.create(:resume, published: true) }

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
          ActsAsTenant.without_tenant do
            FactoryBot.create(:resume, user: other_user, published: true)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns resume' do
        let(:resume) { FactoryBot.create(:resume) }

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
          ActsAsTenant.without_tenant do
            FactoryBot.create(:resume, user: other_user, published: true)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns resume' do
        let(:resume) { FactoryBot.create(:resume) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { ResumePolicy::Scope.new(policy_user, Resume.all).resolve }

    let!(:secret_resumes) { FactoryBot.create_list(:resume, 5, published: false) }
    let!(:published_resumes) { FactoryBot.create_list(:resume, 5, published: true) }

    context 'user is nil' do
      let(:policy_user) { PolicyUser.new(nil, current_tenant) }

      it 'returns only published resumes' do
        expect(subject).to match_array(published_resumes)
      end
    end

    context 'user is not the current tenant' do
      let(:policy_user) { PolicyUser.new(FactoryBot.create(:user, admin: false), current_tenant) }

      it 'returns only published resumes' do
        expect(subject).to match_array(published_resumes)
      end
    end

    context 'user is current_tenant' do
      let(:policy_user) { PolicyUser.new(current_tenant, current_tenant) }

      it 'returns all resumes for the current_tenant' do
        expect(subject).to match_array(secret_resumes + published_resumes)
      end
    end
  end
end
