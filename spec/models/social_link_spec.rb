require 'rails_helper'

RSpec.describe SocialLink, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:social_link)).to be_valid
  end

  it 'is invalid without a url or username' do
    expect(FactoryBot.build(:social_link, url: nil, username: nil)).not_to be_valid
  end

  it 'is invalid without a supported network' do
    expect(FactoryBot.build(:social_link, network: 'facegramtubebooktok')).not_to be_valid
  end

  context 'mastodon' do
    it 'is valid if username provided in expected format' do
      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: '@greg@something')
      ).to be_valid

      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: '@greg@something.biz')
      ).to be_valid

      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: '@greg.biz@something.host')
      ).to be_valid
    end

    it 'is invalid if username is not in the correct format' do
      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: 'greg@')
      ).not_to be_valid
      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: '@something')
      ).not_to be_valid
      expect(
        FactoryBot.build(:social_link, network: 'mastodon', username: '@@hello')
      ).not_to be_valid
    end
  end
end
