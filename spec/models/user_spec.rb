require 'rails_helper'

RSpec.describe User, type: :model do
  def stub_tenancy_mode(mode)
    allow(ResumisConfig).to receive(:tenancy_mode).and_return(mode)
  end

  it 'has a valid factory' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it 'is invalid without a first_name' do
    expect(FactoryBot.build(:user, first_name: nil)).not_to be_valid
  end

  it 'is invalid without a last_name' do
    expect(FactoryBot.build(:user, last_name: nil)).not_to be_valid
  end

  context 'in multi-tenancy mode' do
    before { stub_tenancy_mode(:multi) }

    it 'is invalid without a subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:multi)
      expect(FactoryBot.build(:user, subdomain: nil)).not_to be_valid
    end

    it 'needs a unique subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:multi)
      first_user = FactoryBot.create(:user)

      expect(FactoryBot.build(:user, subdomain: first_user.subdomain)).not_to be_valid
    end
  end

  context 'in single-tenancy mode' do
    before { stub_tenancy_mode(:single) }

    it 'is valid without a subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:single)
      expect(FactoryBot.build(:user, subdomain: nil)).to be_valid
    end
  end

  it 'can not use a reserved subdomain as its subdomain' do
    expect(FactoryBot.build(:user, subdomain: 'accounts')).not_to be_valid
  end

  it 'returns a full_name as a concat. of first_name and last_name' do
    user = FactoryBot.create(:user)

    expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
  end

  describe '#copyright_range' do
    it 'returns only the current year if only one year has spanned since creation' do
      user = FactoryBot.create(:user, created_at: DateTime.now)

      expect(user.copyright_range).to eq("#{DateTime.now.year} #{user.full_name}")
    end

    it 'returns the full span of years if more than a year old' do
      user = FactoryBot.create(:user, created_at: DateTime.new(2001,2,3))

      expect(user.copyright_range).to eq("2001-#{DateTime.now.year} #{user.full_name}")
    end
  end

  describe "#mastodon_url" do
    it "returns the expected shortcut URL" do
      user = FactoryBot.build(:user, mastodon_handle: "@lol@masto.host")

      expect(user.mastodon_url).to eq("https://masto.host/@lol")
    end
  end
end
