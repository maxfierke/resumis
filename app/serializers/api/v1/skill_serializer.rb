module Api
  module V1
    class SkillSerializer < ActiveModel::Serializer
      attributes :id, :name, :created_at, :updated_at

      has_one :skill_category, key: :category
    end
  end
end
