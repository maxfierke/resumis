class Resume < ActiveRecord::Base
  # nice slugs from resume name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :resume_education_experiences
  has_many :resume_projects
  has_many :resume_work_experiences
  has_many :resume_skills
  has_many :education_experiences, through: :resume_education_experiences, dependent: :destroy
  has_many :projects, through: :resume_projects, dependent: :destroy
  has_many :skills, through: :resume_skills, dependent: :destroy
  has_many :work_experiences, through: :resume_work_experiences, dependent: :destroy

  acts_as_tenant(:user)

  validates :name, presence: true
  validates_uniqueness_to_tenant :name

  validates_uniqueness_to_tenant :slug

  def self.latest
    Resume.where(published: true).order(updated_at: :desc).first
  end
end
