module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      include ApplicationHelper

      cache key: 'post', expires_in: 12.hours

      attributes :id, :slug, :title, :body, :published, :published_on,
                 :created_at, :updated_at

      attribute :body_html do
        markdown(object.body)
      end

      link(:self) { api_post_path(object.slug) }

      has_many :post_categories, key: :categories do
        # AMS seems to return ALL project categories unless we do this explicitly
        object.post_categories
      end
      has_one :user
    end
  end
end
