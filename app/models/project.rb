class Project < ActiveRecord::Base
  # nice slugs from project name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :project_status
  belongs_to :user
  has_many :project_category_joinings
  has_many :project_categories, through: :project_category_joinings
  has_many :resumes, through: :resume_project

  acts_as_tenant(:user)

  accepts_nested_attributes_for :project_category_joinings, :allow_destroy => true

  validates :name, presence: true
  validates_uniqueness_to_tenant :name
  validates_uniqueness_to_tenant :slug

  def self.ordered_by_activity
    order(<<-SQL.strip_heredoc
      end_date DESC NULLS FIRST,
      start_date DESC
    SQL
    )
  end

  def status
    project_status
  end

  def date_range
    start_month_year = start_date.strftime('%B %Y')
    end_month_year = end_date ? end_date.strftime('%B %Y') : 'present'

    "#{start_month_year} — #{end_month_year}"
  end

  # TODO: remove. deprecated
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

    links << { rel: 'bandcamp', href: bandcamp_url, label: "#{name} on Bandcamp" } if bandcamp_url.present?
    links << { rel: 'github', href: "https://github.com/#{github_url}", label: "#{name} on GitHub" } if github_url.present?
    links << { rel: 'penflip', href: "https://penflip.com/#{penflip_url}", label: "#{name} on Penflip" } if penflip_url.present?
    links << { rel: 'soundcloud', href: "https://soundcloud.com/#{soundcloud_url}", label: "#{name} on Soundcloud"} if soundcloud_url.present?
    links << { rel: 'vimeo', href: "https://vimeo.com/#{vimeo_url}", label: "#{name} on Vimeo" } if vimeo_url.present?
    links << { rel: 'youtube', href: "https://youtube.com/watch?v=#{youtube_url}", label: "#{name} on YouTube"} if youtube_url.present?

    links
  end
end
