module Api
  module V1
    class SkillCategorySerializer < ActiveModel::Serializer
      cache key: 'skill_category', expires_in: 12.hours

      attributes :id, :name, :created_at, :updated_at
    end
  end
end
