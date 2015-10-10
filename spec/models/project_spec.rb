require 'rails_helper'

RSpec.describe Project, type: :model do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:project)).to be_valid
  end

  it 'is invalid without a name unique to the user' do
    FactoryGirl.create(:project, name: 'i am proj')

    expect(FactoryGirl.build(:project, name: 'i am proj')).not_to be_valid
  end

  describe '#css_classes' do
    it 'outputs css classes for each project category' do
      proj = FactoryGirl.create(:project,
        project_categories: [
          FactoryGirl.create(:project_category, slug: 'one'),
          FactoryGirl.create(:project_category, slug: 'two')
        ],
        start_date: DateTime.new(2014,1,1),
        end_date: nil
      )
      expect(proj.css_classes).to include('current-projects', 'one', 'two')

      proj2 = FactoryGirl.create(:project,
        project_categories: [
          FactoryGirl.create(:project_category, slug: 'three'),
          FactoryGirl.create(:project_category, slug: 'four')
        ],
        start_date: DateTime.new(2013,4,1),
        end_date: DateTime.new(2015,8,16)
      )
      expect(proj2.css_classes).to include('past-projects', 'three', 'four')
    end
  end

  describe '#date_range' do
    it "returns 'Month Year - present' without an end_date" do
      proj = FactoryGirl.create(:project,
                                start_date: DateTime.new(2014,1,1),
                                end_date: nil)

      expect(proj.date_range).to eq("January 2014 — present")
    end

    it "returns 'Month Year - Month Year' with an end_date" do
      proj = FactoryGirl.create(:project,
                                start_date: DateTime.new(2013,4,1),
                                end_date: DateTime.new(2015,8,16))

      expect(proj.date_range).to eq("April 2013 — August 2015")
    end
  end

  describe '#links' do
    it 'returns a list of links for attached services' do
      proj = FactoryGirl.create(:project,
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
