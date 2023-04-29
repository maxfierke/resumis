class SkillCategory < ActiveRecord::Base
  has_many :skills
  belongs_to :user

  default_scope { order(name: :asc) }

  validates :name, presence: true, uniqueness: { scope: :user }
end
