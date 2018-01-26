require 'rails_helper'

RSpec.describe CreateUserDefaultsJob, :type => :job do
  let(:user) { FactoryBot.create(:user) }

  it 'should create standard project statuses' do
    CreateUserDefaultsJob.new().perform(user)

    ActsAsTenant.with_tenant(user) do
      expect(ProjectStatus.count).to eql(4)
    end
  end

  it 'should create default developer skill categories' do
    CreateUserDefaultsJob.new().perform(user)

    ActsAsTenant.with_tenant(user) do
      expect(SkillCategory.count).to eql(5)
    end
  end
end
