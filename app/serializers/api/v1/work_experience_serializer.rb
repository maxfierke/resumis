module Api
  module V1
    class WorkExperienceSerializer < ActiveModel::Serializer
      cache key: 'work_experience', expires_in: 12.hours

      attributes :id, :organization, :description, :start_date, :end_date,
                 :position, :created_at, :updated_at

      link(:self) { api_work_experience_path(object.id) }
    end
  end
end
