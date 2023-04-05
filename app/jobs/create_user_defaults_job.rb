class CreateUserDefaultsJob < ApplicationJob
  queue_as :default

  PROJECT_STATUSES = [
    { slug: 'active', name: 'Active' },
    { slug: 'inactive', name: 'Inactive' },
    { slug: 'canceled', name: 'Canceled' },
    { slug: 'on-hold', name: 'On Hold' }
  ].freeze
  SKILL_CATEGORIES = [
    { name: 'Languages' },
    { name: 'Web Development Frameworks' },
    { name: 'Database Servers' },
    { name: 'Development Utilities' },
    { name: 'Cloud Platforms' }
  ].freeze

  def perform(user)
    ProjectStatus.create(PROJECT_STATUSES.map { |s| s.merge(user: user) })
    SkillCategory.create(SKILL_CATEGORIES.map { |c| c.merge(user: user) })
  end
end
