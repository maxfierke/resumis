require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:type)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:type, name: nil)).not_to be_valid
  end

  it 'is invalid without a unique slug' do
    first_type = FactoryGirl.create(:type)

    expect(FactoryGirl.build(:type, slug: first_type.slug)).not_to be_valid
  end
end
