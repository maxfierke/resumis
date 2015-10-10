require 'rails_helper'

RSpec.describe Resume, type: :model do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:resume)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:resume, name: nil)).not_to be_valid
  end
end
