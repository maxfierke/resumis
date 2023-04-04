class Resume < ActiveRecord::Base
  # nice slugs from resume name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  paginates_per 10

  belongs_to :user
  has_many :resume_education_experiences
  has_many :resume_projects
  has_many :resume_work_experiences
  has_many :resume_skills
  has_many :education_experiences, through: :resume_education_experiences, dependent: :destroy
  has_many :projects, through: :resume_projects, dependent: :destroy
  has_many :skills, through: :resume_skills, dependent: :destroy
  has_many :work_experiences, through: :resume_work_experiences, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :slug, presence: true, uniqueness: { scope: :user }

  def self.latest
    Resume.where(published: true).order(updated_at: :desc).first
  end
end
