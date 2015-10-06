require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryGirl.create(:post_category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:post_category, name: nil)).not_to be_valid
  end
end
