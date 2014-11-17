class ResumeWorkExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :work_experience
end
