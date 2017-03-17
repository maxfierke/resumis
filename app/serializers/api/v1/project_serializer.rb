module Api
  module V1
    class ProjectSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :id, :slug, :name, :short_description, :description,
                 :date_range, :start_date, :end_date, :created_at, :updated_at

      attribute :description_html do
        markdown(object.description)
      end

      link(:self) { api_v1_project_path(object.id) }
      link(:github) { "https://github.com/#{object.github_url}" }
      has_one :project_status, key: :status
      has_many :project_categories, key: :categories
    end
  end
end
