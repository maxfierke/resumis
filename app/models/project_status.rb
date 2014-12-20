class ProjectStatus < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
