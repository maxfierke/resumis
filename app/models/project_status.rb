class ProjectStatus < ActiveRecord::Base
  has_many :projects
  belongs_to :user

  default_scope { order(name: :asc) }

  # nice slugs from category name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :slug, presence: true, uniqueness: { scope: :user }
end
