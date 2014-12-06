class WorkExperience < ActiveRecord::Base
  belongs_to :user
  has_many :resumes, through: :resume_work_experience

  default_scope { order(end_date: :desc) }

  def date_range
    start_month_year = start_date.strftime('%B %Y')
    end_month_year = end_date ? end_date.strftime('%B %Y') : 'present'

    "#{start_month_year} — #{end_month_year}"
  end
end
