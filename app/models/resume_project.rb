class ResumeProject < ActiveRecord::Base
  belongs_to :resume
  belongs_to :project
end
