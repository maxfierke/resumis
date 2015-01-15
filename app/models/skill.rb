class Skill < ActiveRecord::Base
  belongs_to :skill_category
  belongs_to :user

  acts_as_tenant(:user)

  default_scope { order(name: :asc) }

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
