require 'rails_helper'

RSpec.describe EducationExperience, type: :model do
  it 'has a valid factory'
  it 'is invalid without an school_name'
  it 'is invalid with an school_name less than 5 characters'
  it 'is invalid with an school_name greater than 255 characters'
  it 'is invalid without a diploma'
  it 'is invalid with a diploma less than 2 characters'
  it 'is invalid with a diploma greater than 255 characters'
  it 'is invalid without a start_date'

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date"
    it "returns 'Month Year - Month Year' with an end_date"
  end
end
