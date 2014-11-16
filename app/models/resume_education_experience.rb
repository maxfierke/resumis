class ResumeEducationExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :EducationExperience
end
