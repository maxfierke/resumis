require 'rails_helper'

RSpec.describe Resume, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:resume)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryBot.build(:resume, name: nil)).not_to be_valid
  end
end
