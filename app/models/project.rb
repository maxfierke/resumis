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

  def links
    links = []

    links << { rel: 'bandcamp', href: bandcamp_url } if bandcamp_url.present?
    links << { rel: 'github', href: "https://github.com/#{github_url}" } if github_url.present?
    links << { rel: 'penflip', href: "https://penflip.com/#{penflip_url}" } if penflip_url.present?
    links << { rel: 'soundcloud', href: "https://soundcloud.com/#{soundcloud_url}"} if soundcloud_url.present?
    links << { rel: 'vimeo', href: "https://vimeo.com/#{vimeo_url}" } if vimeo_url.present?
    links << { rel: 'youtube', href: "https://youtube.com/watch?v=#{youtube_url}"} if youtube_url.present?

    links
  end
end
