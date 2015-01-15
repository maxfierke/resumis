class ProjectCategory < ActiveRecord::Base
  has_many :project_category_joinings
  has_many :projects, through: :project_category_joinings

  default_scope { order(name: :asc) }

  scope :with_projects, -> { joins(:project_category_joinings).where('project_category_joinings.project_category_id IS NOT NULL').group('project_categories.id') }

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
