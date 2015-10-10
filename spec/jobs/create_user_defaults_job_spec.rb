require 'rails_helper'

RSpec.describe CreateUserDefaultsJob, :type => :job do
  it 'should create standard project statuses' do
    user = FactoryGirl.create(:user)

    CreateUserDefaultsJob.new().perform(user)

    ActsAsTenant.with_tenant(user) do
      expect(ProjectStatus.count).to eql(4)
    end
  end

  context 'developers' do
    let (:user) do
      FactoryGirl.create(:user, types: [
        Type.first_or_create(slug: 'developer', name: 'Developer')
      ])
    end

    it 'should create default developer skill categories' do
      CreateUserDefaultsJob.new().perform(user)

      ActsAsTenant.with_tenant(user) do
        expect(SkillCategory.count).to eql(5)
      end
    end
  end
end
