require 'rails_helper'

describe UserDisabler do
  let(:user) { FactoryBot.create(:user, locked_at: nil) }
  let(:other_user) { FactoryBot.create(:user, locked_at: nil) }
  let!(:access_tokens) do
    FactoryBot.create_list(:access_token, 3,
      revoked_at: nil,
      resource_owner_id: user.id
    )
  end
  let!(:access_grants) do
    FactoryBot.create_list(:access_grant, 3,
      revoked_at: nil,
      resource_owner_id: user.id
    )
  end
  let(:other_access_token) do
    FactoryBot.create(:access_token,
      revoked_at: nil,
      resource_owner_id: other_user.id
    )
  end
  let(:other_access_grant) do
    FactoryBot.create(:access_grant,
      revoked_at: nil,
      resource_owner_id: other_user.id
    )
  end

  subject { described_class.new(user) }

  before { ActsAsTenant.current_tenant = user }
  after { ActsAsTenant.current_tenant = nil }

  it "locks the users account" do
    subject.disable!

    expect(user.locked_at).not_to be_nil
  end

  it "revokes the access tokens for the user" do
    subject.disable!

    all_access_tokens_revoked = user.oauth_access_tokens.all? do |token|
      token.revoked_at.present?
    end

    expect(all_access_tokens_revoked).to eq(true)
  end

  it "revokes the access grants for the user" do
    subject.disable!

    all_access_grants_revoked = user.oauth_access_grants.all? do |grant|
      grant.revoked_at.present?
    end

    expect(all_access_grants_revoked).to eq(true)
  end

  it "does not revoke another users access tokens" do
    subject.disable!

    expect(other_access_token.reload.revoked_at).to be_nil
  end

  it "does not revoke another users access grants" do
    subject.disable!

    expect(other_access_grant.reload.revoked_at).to be_nil
  end
end
