class ProjectCategory < ActiveRecord::Base
  has_many :projects, through: :project_category_joinings

  default_scope { order(name: :asc) }
end
