require 'rails_helper'
require 'faker'

RSpec.describe EducationExperience, type: :model do
  before { ActsAsTenant.current_tenant = FactoryBot.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryBot.create(:education_experience)).to be_valid
  end

  it 'is invalid without a school_name' do
    expect(FactoryBot.build(:education_experience, school_name: nil)).not_to be_valid
  end

  it 'is invalid with an school_name less than 5 characters' do
    expect(FactoryBot.build(:education_experience, school_name: 'aaa')).not_to be_valid
  end

  it 'is invalid with an school_name greater than 255 characters' do
    expect(FactoryBot.build(:education_experience, school_name: Faker::Lorem.characters(number: 256))).not_to be_valid
  end

  it 'is invalid without a diploma' do
    expect(FactoryBot.build(:education_experience, diploma: nil)).not_to be_valid
  end

  it 'is invalid with a diploma less than 2 characters' do
    expect(FactoryBot.build(:education_experience, diploma: 'a')).not_to be_valid
  end

  it 'is invalid with a diploma greater than 255 characters' do
    expect(FactoryBot.build(:education_experience, diploma: Faker::Lorem.characters(number: 256))).not_to be_valid
  end

  it 'is invalid without a start_date' do
    expect(FactoryBot.build(:education_experience, start_date: nil)).not_to be_valid
  end

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date" do
      ed_exp = FactoryBot.create(:education_experience,
                                  start_date: DateTime.new(2014,1,1),
                                  end_date: nil)

      expect(ed_exp.date_range).to eq("January 2014 — present")
    end

    it "returns 'Month Year - Month Year' with an end_date" do
      ed_exp = FactoryBot.create(:education_experience,
                                  start_date: DateTime.new(2013,4,1),
                                  end_date: DateTime.new(2015,8,16))

      expect(ed_exp.date_range).to eq("April 2013 — August 2015")
    end
  end
end
