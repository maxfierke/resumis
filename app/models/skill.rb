class Skill < ActiveRecord::Base
  belongs_to :skill_category
  belongs_to :user
  has_many :resume_skills
  has_many :resumes, through: :resume_skills, dependent: :destroy

  default_scope { order(name: :asc) }

  validates :name, presence: true, uniqueness: { scope: :user }
end
