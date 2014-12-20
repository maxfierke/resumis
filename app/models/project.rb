class Project < ActiveRecord::Base
  belongs_to :project_status
  belongs_to :user
  has_many :project_category_joinings
  has_many :project_categories, through: :project_category_joinings
  has_many :resumes, through: :resume_project

  acts_as_tenant(:user)

  accepts_nested_attributes_for :project_category_joinings, :allow_destroy => true

  validates :name, presence: true, uniqueness: { scope: :user_id }

  default_scope { order(start_date: :desc, end_date: :desc) }

  def date_range
    start_month_year = start_date.strftime('%B %Y')
    end_month_year = end_date ? end_date.strftime('%B %Y') : 'present'

    "#{start_month_year} — #{end_month_year}"
  end

  def css_classes
    classes = []
    if end_date
      classes << "past-projects"
    else
      classes << "current-projects"
    end

    if project_categories
      project_categories.each do |c|
        classes << c.slug
      end
    end

    classes.join(" ")
  end
end
