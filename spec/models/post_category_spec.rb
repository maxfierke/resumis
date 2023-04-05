require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:post_category)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryBot.build(:post_category, name: nil)).not_to be_valid
  end
end
