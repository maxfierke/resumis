require 'rails_helper'

RSpec.describe Project, type: :model do
  before { ActsAsTenant.current_tenant = FactoryBot.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryBot.build(:project)).to be_valid
  end

  it 'is invalid without a name unique to the user' do
    FactoryBot.create(:project, name: 'i am proj')

    expect(FactoryBot.build(:project, name: 'i am proj')).not_to be_valid
  end

  describe '.featured' do
    before do
      @featured_project = FactoryBot.create(:project, featured: true)
      @normal_project = FactoryBot.create(:project, featured: false)
    end

    let(:result){ described_class.featured }

    it 'returns all featured projects' do
      expect(result).to include(@featured_project)
      expect(result).not_to include(@normal_project)
    end
  end

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date" do
      proj = FactoryBot.create(:project,
                                start_date: DateTime.new(2014,1,1),
                                end_date: nil)

      expect(proj.date_range).to eq("January 2014 — present")
    end

    it "returns 'Month Year - Month Year' with an end_date" do
      proj = FactoryBot.create(:project,
                                start_date: DateTime.new(2013,4,1),
                                end_date: DateTime.new(2015,8,16))

      expect(proj.date_range).to eq("April 2013 — August 2015")
    end
  end

  describe '#links' do
    it 'returns a list of links for attached services' do
      proj = FactoryBot.create(:project,
                                name: 'Resumis',
                                github_url: 'maxfierke/resumis')

      expect(proj.links).to include({
        rel: 'github',
        href: 'https://github.com/maxfierke/resumis',
        label: 'Resumis on GitHub'
      })
    end
  end
end
