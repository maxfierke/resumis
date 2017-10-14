require 'rails_helper'

describe Api::V1::ProjectSerializer do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  describe "categories" do
    let(:project_categories) { FactoryGirl.create_list(:project_category, 4) }
    let(:project) do
      FactoryGirl.create(:project,
        project_categories: project_categories[0...2]
      )
    end
    subject { described_class.new(project) }

    it "serializes only the categories to which the project belongs" do
      serialized = subject.as_json
      categories = serialized[:categories]
      expect(categories.size).to eq(2)
    end
  end
end