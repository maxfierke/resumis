class EducationExperience < ActiveRecord::Base
	belongs_to :user
	has_many :resumes, through: :resume_education_experience
end
