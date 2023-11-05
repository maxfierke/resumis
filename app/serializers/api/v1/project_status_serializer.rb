module Api
  module V1
    class ProjectStatusSerializer < ActiveModel::Serializer
      cache key: 'project_status', expires_in: 12.hours

      attributes :id, :slug, :name, :created_at, :updated_at
    end
  end
end
