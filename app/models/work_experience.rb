class WorkExperience < ActiveRecord::Base
  paginates_per 10

  belongs_to :user
  has_many :resume_work_experiences
  has_many :resumes, through: :resume_work_experiences, dependent: :destroy

  default_scope { order(end_date: :desc) }

  validates :organization, presence: true, length: { minimum: 2, maximum: 255 }
  validates :position, presence: true, length: { minimum: 3, maximum: 255 }
  validates :start_date, presence: true

  def date_range
    start_month_year = start_date.strftime('%B %Y')
    end_month_year = end_date ? end_date.strftime('%B %Y') : 'present'

    "#{start_month_year} — #{end_month_year}"
  end
end
