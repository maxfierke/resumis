require 'rails_helper'

RSpec.describe ProjectStatus, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:project_status)).to be_valid
  end

  it 'is invalid without a unique name' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project_status, name: 'I am a project status', user: user)

    expect(
      FactoryBot.build(
        :project_status,
        name: 'I am a project status',
        user: user
      )
    ).not_to be_valid
    expect(
      FactoryBot.build(
        :project_status,
        name: 'I am a project status',
        user: FactoryBot.create(:user)
      )
    ).to be_valid
  end

  it 'is invalid without a unique slug' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project_status, slug: 'test-status', user: user)

    expect(
      FactoryBot.build(
        :project_status,
        slug: 'test-status',
        user: user
      )
    ).not_to be_valid
    expect(
      FactoryBot.build(
        :project_status,
        slug: 'test-status',
        user: FactoryBot.create(:user)
      )
    ).to be_valid
  end
end
