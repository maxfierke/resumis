require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:work_experience)).to be_valid
  end

  it 'is invalid without an organization' do
    expect(FactoryBot.build(:work_experience, organization: nil)).not_to be_valid
  end

  it 'is invalid with an organization less than 2 characters' do
    expect(FactoryBot.build(:work_experience, organization: 'M')).not_to be_valid
  end

  it 'is invalid with an organization greater than 255 characters' do
    expect(FactoryBot.build(:work_experience, organization: Faker::Lorem.characters(number: 256))).not_to be_valid
  end

  it 'is invalid without a position' do
    expect(FactoryBot.build(:work_experience, position: nil)).not_to be_valid
  end

  it 'is invalid with a position less than 3 characters' do
    expect(FactoryBot.build(:work_experience, position: 'aa')).not_to be_valid
  end

  it 'is invalid with a position greater than 255 characters' do
    expect(FactoryBot.build(:work_experience, position: Faker::Lorem.characters(number: 256))).not_to be_valid
  end

  it 'is invalid without a start_date' do
    expect(FactoryBot.build(:work_experience, start_date: nil)).not_to be_valid
  end

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date" do
      work_exp = FactoryBot.create(:work_experience,
                                    start_date: DateTime.new(2014,1,1),
                                    end_date: nil)

      expect(work_exp.date_range).to eq("January 2014 — present")
    end

    it "returns 'Month Year - Month Year' with an end_date" do
      work_exp = FactoryBot.create(:work_experience,
                                    start_date: DateTime.new(2013,4,1),
                                    end_date: DateTime.new(2015,8,16))

      expect(work_exp.date_range).to eq("April 2013 — August 2015")
    end
  end
end
