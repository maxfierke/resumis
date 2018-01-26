require 'rails_helper'

RSpec.describe SkillCategory, type: :model do
  before { ActsAsTenant.current_tenant = FactoryBot.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryBot.create(:skill_category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryBot.build(:skill_category, name: nil)).not_to be_valid
  end

  it 'is unique to a tenanted user' do
    FactoryBot.create(:skill_category, name: 'I am a cat')

    expect(FactoryBot.build(:skill_category, name: 'I am a cat')).not_to be_valid
  end
end
