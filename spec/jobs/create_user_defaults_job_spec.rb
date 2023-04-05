require 'rails_helper'

RSpec.describe CreateUserDefaultsJob, type: :job do
  let(:user) { FactoryBot.create(:user) }

  it 'should create standard project statuses' do
    CreateUserDefaultsJob.perform_now(user)

    expect(ProjectStatus.where(user: user).count).to eql(4)
  end

  it 'should create default developer skill categories' do
    CreateUserDefaultsJob.perform_now(user)

    expect(SkillCategory.where(user: user).count).to eql(5)
  end
end
