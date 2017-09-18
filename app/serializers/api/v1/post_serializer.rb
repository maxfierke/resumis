module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :id, :slug, :title, :body, :published, :published_on,
                 :created_at, :updated_at

      attribute :body_html do
        markdown(object.body)
      end

      link(:self) { api_post_path(object.slug) }
      has_many :post_categories, key: :categories
      has_one :user
    end
  end
end
