module Api
  module V1
    class ProjectSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :id, :slug, :name, :short_description, :description,
                 :date_range, :start_date, :end_date, :created_at, :updated_at, :featured

      attribute :description_html do
        markdown(object.description)
      end

      link(:self) { api_project_path(object.id) }
      link(:github) {
        {
          meta: {
            rel: 'github',
            title: "@#{object.github_url}"
          },
          href: "https://github.com/#{object.github_url}"
        }
      }
      has_one :project_status, key: :status
      has_many :project_categories, key: :categories do
        # AMS seems to return ALL project categories unless we do this explicitly
        object.project_categories
      end
    end
  end
end
