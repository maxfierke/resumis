class ProjectCategory < ActiveRecord::Base
  has_many :project_category_joinings
  has_many :projects, through: :project_category_joinings, dependent: :destroy
  belongs_to :user

  default_scope { order(name: :asc) }

  # nice slugs from category name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  scope :with_projects, -> { joins(:project_category_joinings).where('project_category_joinings.project_category_id IS NOT NULL').group('project_categories.id') }

  validates :name, presence: true, uniqueness: { scope: :user }
end
