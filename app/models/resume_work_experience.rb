class ResumeWorkExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :work_experience

  validates_presence_of :resume
  validates_presence_of :work_experience

  accepts_nested_attributes_for :work_experience
end
