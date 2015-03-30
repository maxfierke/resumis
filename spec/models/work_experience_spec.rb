require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  it 'has a valid factory'
  it 'is invalid without an organization'
  it 'is invalid with an organization less than 2 characters'
  it 'is invalid with an organization greater than 255 characters'
  it 'is invalid without a position'
  it 'is invalid with a position less than 3 characters'
  it 'is invalid with a position greater than 255 characters'
  it 'is invalid without a start_date'

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date"
    it "returns 'Month Year - Month Year' with an end_date"
  end
end
