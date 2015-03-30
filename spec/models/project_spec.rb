require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'has a valid factory'
  it 'is invalid without a name unique to the user'

  describe '#css_classes' do
    it 'outputs css classes for each project category'
  end

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date"
    it "returns 'Month Year - Month Year' with an end_date"
  end

  describe '#links' do
    it 'returns a list of links for attached services'
  end
end
