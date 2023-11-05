module Api
  module V1
    class SkillSerializer < ActiveModel::Serializer
      cache key: 'skill', expires_in: 12.hours

      attributes :id, :name, :created_at, :updated_at

      has_one :skill_category, key: :category
    end
  end
end
