class ResumeEducationExperience < ActiveRecord::Base
  belongs_to :resume
  belongs_to :education_experience

  validates_presence_of :resume
  validates_presence_of :education_experience

  accepts_nested_attributes_for :education_experience
end
