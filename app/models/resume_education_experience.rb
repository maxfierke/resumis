class ResumeEducationExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :education_experience
end
