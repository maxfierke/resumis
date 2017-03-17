module Api
  module V1
    class ProjectCategorySerializer < ActiveModel::Serializer
      type :project_category

      attributes :id, :slug, :name, :created_at, :updated_at
    end
  end
end