require 'rails_helper'

describe Api::V1::PostSerializer do
  before { ActsAsTenant.current_tenant = FactoryGirl.create :user }
  after { ActsAsTenant.current_tenant = nil }

  describe "categories" do
    let(:post_categories) { FactoryGirl.create_list(:post_category, 4) }
    let(:post) do
      FactoryGirl.create(:post,
        post_categories: post_categories[0...2]
      )
    end
    subject { described_class.new(post) }

    it "serializes only the categories to which the post belongs" do
      serialized = subject.as_json
      categories = serialized[:categories]
      expect(categories.size).to eq(2)
    end
  end
end