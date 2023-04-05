require 'rails_helper'

RSpec.describe Skill, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:skill)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryBot.build(:skill, name: nil)).not_to be_valid
  end

  it 'is unique to a tenanted user' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:skill, name: 'I am a skill', user: user)

    expect(FactoryBot.build(:skill, name: 'I am a skill', user: user)).not_to be_valid
    expect(
      FactoryBot.build(
        :skill,
        name: 'I am a skill',
        user: FactoryBot.create(:user)
      )
    ).to be_valid
  end
end
