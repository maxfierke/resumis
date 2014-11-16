class ProjectCategoryJoining < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_category
end
