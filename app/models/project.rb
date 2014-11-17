class Project < ActiveRecord::Base
  belongs_to :project_status
  belongs_to :user
  has_many :project_categories, through: :project_category_joining
  has_many :resumes, through: :resume_project
end
