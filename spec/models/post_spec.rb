require 'rails_helper'

RSpec.describe Post, type: :model do
  before { ActsAsTenant.current_tenant = FactoryBot.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryBot.create(:post)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryBot.build(:post, title: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate title (by user)' do
    FactoryBot.create(:post, title: 'I am a post')

    expect(FactoryBot.build(:post, title: 'I am a post')).not_to be_valid
  end

  it 'is invalid with a title less than 3 characters' do
    expect(FactoryBot.build(:post, title: 'ab')).not_to be_valid
  end

  it 'is invalid with a title greater than 60 characters' do
    long_title = Faker::Lorem.characters(61)

    expect(FactoryBot.build(:post, title: long_title)).not_to be_valid
  end

  it 'should be deleteable with attached categories' do
    categories = 3.times.collect do
      FactoryBot.create(:post_category)
    end

    post = FactoryBot.create(:post, post_categories: categories)

    expect { post.destroy! }.not_to raise_error
  end
end
