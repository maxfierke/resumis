require 'rails_helper'
require 'digest'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it 'is invalid without a first_name' do
    expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
  end

  it 'is invalid without a last_name' do
    expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
  end

  describe 'in multi-tenancy mode' do
    before(:each) { Rails.application.config.x.resumis.tenancy_mode = :multi }

    it 'is invalid without a subdomain in multi-tenancy mode' do
      expect(Rails.application.config.x.resumis.tenancy_mode).to eq(:multi)
      expect(FactoryGirl.build(:user, subdomain: nil)).not_to be_valid
    end

    it 'needs a unique subdomain in multi-tenancy mode' do
      expect(Rails.application.config.x.resumis.tenancy_mode).to eq(:multi)
      first_user = FactoryGirl.create(:user)

      expect(FactoryGirl.build(:user, subdomain: first_user.subdomain)).not_to be_valid
    end
  end

  it 'can not use a reserved subdomain as its subdomain' do
    expect(FactoryGirl.build(:user, subdomain: 'accounts')).not_to be_valid
  end

  it 'returns a full_name as a concat. of first_name and last_name' do
    user = FactoryGirl.create(:user)

    expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
  end

  describe '#copyright_range' do
    it 'returns only the current year if only one year has spanned since creation' do
      user = FactoryGirl.create(:user, created_at: DateTime.now)

      expect(user.copyright_range).to eq("#{DateTime.now.year} #{user.full_name}")
    end

    it 'returns the full span of years if more than a year old' do
      user = FactoryGirl.create(:user, created_at: DateTime.new(2001,2,3))

      expect(user.copyright_range).to eq("2001-#{DateTime.now.year} #{user.full_name}")
    end
  end
end
