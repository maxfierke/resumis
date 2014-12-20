class ProjectCategory < ActiveRecord::Base
  has_many :projects, through: :project_category_joinings

  default_scope { order(name: :asc) }

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
