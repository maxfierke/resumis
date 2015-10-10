require 'rails_helper'

RSpec.describe Skill, type: :model do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryGirl.create(:skill)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:skill, name: nil)).not_to be_valid
  end

  it 'is unique to a tenanted user' do
    FactoryGirl.create(:skill, name: 'I am a skill')

    expect(FactoryGirl.build(:skill, name: 'I am a skill')).not_to be_valid
  end
end
