require 'rails_helper'

RSpec.describe SkillCategory, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:skill_category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryBot.build(:skill_category, name: nil)).not_to be_valid
  end

  it 'is unique to a tenanted user' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:skill_category, name: 'I am a cat', user: user)

    expect(
      FactoryBot.build(:skill_category, name: 'I am a cat', user: user)
    ).not_to be_valid
    expect(
      FactoryBot.build(
        :skill_category,
        name: 'I am a cat',
        user: FactoryBot.create(:user)
      )
    ).to be_valid
  end
end
