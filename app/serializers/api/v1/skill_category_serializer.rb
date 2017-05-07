module Api
  module V1
    class SkillCategorySerializer < ActiveModel::Serializer
      attributes :id, :name, :created_at, :updated_at
    end
  end
end
