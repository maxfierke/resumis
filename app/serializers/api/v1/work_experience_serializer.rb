module Api
  module V1
    class WorkExperienceSerializer < ActiveModel::Serializer
      attributes :id, :organization, :description, :start_date, :end_date,
                 :position, :created_at, :updated_at

      link(:self) { api_work_experience_path(object.id) }
    end
  end
end
