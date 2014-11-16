class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :education_experiences, through: :resume_education_experiences
  has_many :work_experiences, through: :resume_work_experiences
end
