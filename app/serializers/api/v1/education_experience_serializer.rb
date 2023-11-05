module Api
  module V1
    class EducationExperienceSerializer < ActiveModel::Serializer
      cache key: 'education_experience', expires_in: 12.hours

      attributes :id, :school_name, :description, :start_date, :end_date,
                 :diploma, :created_at, :updated_at

      link(:self) { api_education_experience_path(object.id) }
    end
  end
end
