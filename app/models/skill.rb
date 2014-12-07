class Skill < ActiveRecord::Base
  belongs_to :skill_category
  belongs_to :user

  acts_as_tenant(:user)
end
