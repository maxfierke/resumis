class EducationExperience < ActiveRecord::Base
  belongs_to :user
  has_many :resumes, through: :resume_education_experience

  default_scope { order(start_date: :asc, end_date: :asc) }
end
