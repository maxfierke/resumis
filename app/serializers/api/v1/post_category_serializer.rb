module Api
  module V1
    class PostCategorySerializer < ActiveModel::Serializer
      cache key: 'post_category', expires_in: 12.hours

      attributes :id, :slug, :name, :created_at, :updated_at
    end
  end
end
