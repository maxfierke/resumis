module Api
  module V1
    class PostCategorySerializer < ActiveModel::Serializer
      attributes :id, :slug, :name, :created_at, :updated_at
    end
  end
end
