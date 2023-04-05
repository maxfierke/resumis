require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:post)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryBot.build(:post, title: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate title (by user)' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, title: 'I am a post', user: user)

    expect(FactoryBot.build(:post, title: 'I am a post', user: user)).not_to be_valid
    expect(
      FactoryBot.build(
        :project,
        name: 'i am post',
        user: FactoryBot.create(:user)
      )
    ).to be_valid
  end

  it 'is invalid with a title less than 3 characters' do
    expect(FactoryBot.build(:post, title: 'ab')).not_to be_valid
  end

  it 'is invalid with a title greater than 60 characters' do
    long_title = Faker::Lorem.characters(number: 61)

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
