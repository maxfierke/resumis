require 'rails_helper'

RSpec.describe Post, type: :model do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryGirl.create(:post)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:post, title: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate title (by user)'
  it 'is invalid with a title less than 3 characters'
  it 'is invalid with a title greater than 60 characters'
end
