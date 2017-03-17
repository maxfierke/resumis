module Api
  module V1
    class ProjectStatusSerializer < ActiveModel::Serializer
      type :project_status

      attributes :id, :slug, :name, :created_at, :updated_at
    end
  end
end