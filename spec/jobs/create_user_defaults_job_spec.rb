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
    let(:developer_type) { FactoryGirl.create(:type, slug: 'developer') }

    it 'should create default developer skill categories' do
      user = FactoryGirl.create(:user, types: [developer_type])

      CreateUserDefaultsJob.new().perform(user)

      ActsAsTenant.with_tenant(user) do
        expect(SkillCategory.count).to eql(5)
      end
    end
  end
end
