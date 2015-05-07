class SkillCategory < ActiveRecord::Base
  has_many :skills
  belongs_to :user

  acts_as_tenant(:user)

  default_scope { order(name: :asc) }

  scope :with_skills, -> { joins(:skills).where('skills.id IS NOT NULL').group('skill_categories.id') }

  validates :name, presence: true
  validates_uniqueness_to_tenant :name
end
