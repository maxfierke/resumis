class ResumeSkill < ActiveRecord::Base
  belongs_to :resume
  belongs_to :skill
end
