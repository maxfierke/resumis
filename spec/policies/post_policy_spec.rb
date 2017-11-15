require 'rails_helper'

RSpec.describe PostPolicy do
  let(:user) { FactoryGirl.create(:user, admin: false) }
  before { ActsAsTenant.current_tenant = user }
  after { ActsAsTenant.current_tenant = nil }

  describe 'actions' do
    subject { described_class.new(policy_user, post) }

    context 'user is nil' do
      let(:post) { FactoryGirl.create(:post) }
      let(:policy_user) { PolicyUser.new(nil) }

      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }

      context 'post is published' do
        let(:post) { FactoryGirl.create(:post, published: true) }

        it { is_expected.to permit_action(:show) }
      end
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

      context "user doesn't own the post" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:post) do
          ActsAsTenant.without_tenant do
            FactoryGirl.create(:post, user: other_user, published: true)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns post' do
        let(:post) { FactoryGirl.create(:post) }

        context "token doesn't have posts_write scope" do
          it { is_expected.to permit_actions([:index, :show]) }
          it { is_expected.to forbid_actions([:create, :update, :destroy]) }
        end

        context 'token has posts_write scope' do
          let(:access_token) do
            FactoryGirl.create(
              :access_token,
              resource_owner_id: user.id,
              scopes: 'posts_write'
            )
          end

          it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
        end
      end
    end

    context 'user is a browser user' do
      let(:policy_user) { PolicyUser.new(user) }

      context "user doesn't own the post" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:post) do
          ActsAsTenant.without_tenant do
            FactoryGirl.create(:post, user: other_user, published: true)
          end
        end

        it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
      end

      context 'user owns post' do
        let(:post) { FactoryGirl.create(:post) }

        it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
      end
    end
  end

  describe 'scope' do
    subject { PostPolicy::Scope.new(policy_user, Post).resolve }

    let!(:secret_posts) { FactoryGirl.create_list(:post, 5, published: false) }
    let!(:published_posts) { FactoryGirl.create_list(:post, 5, published: true) }

    context 'user is nil' do
      let(:policy_user) { PolicyUser.new(nil) }

      it 'returns only published posts' do
        expect(subject).to match_array(published_posts)
      end
    end

    context 'user exists' do
      let(:policy_user) { PolicyUser.new(user) }

      it 'returns all posts for the user' do
        expect(subject).to match_array(secret_posts + published_posts)
      end
    end
  end
end
