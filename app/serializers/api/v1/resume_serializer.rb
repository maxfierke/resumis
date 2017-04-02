module Api
  module V1
    class ResumeSerializer < ActiveModel::Serializer
      attributes :id, :slug, :name, :background, :description,
                 :published, :created_at, :updated_at

      link(:self) { api_resume_path(object.id) }

      has_many :education_experiences
      has_many :projects
      has_many :skills
      has_many :work_experiences
    end
  end
end
