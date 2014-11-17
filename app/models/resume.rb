class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :resume_education_experiences
  has_many :resume_projects
  has_many :resume_work_experiences
  has_many :resume_skills
  has_many :education_experiences, through: :resume_education_experiences
  has_many :projects, through: :resume_projects
  has_many :skills, through: :resume_skills
  has_many :work_experiences, through: :resume_work_experiences
end
