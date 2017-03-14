class CreateUserDefaultsJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActsAsTenant.with_tenant(user) do
      ProjectStatus.create([
        { slug: 'active', name: 'Active' },
        { slug: 'inactive', name: 'Inactive' },
        { slug: 'canceled', name: 'Canceled' },
        { slug: 'on-hold', name: 'On Hold' }
      ])

      SkillCategory.create([
        { name: 'Languages' },
        { name: 'Web Development Frameworks' },
        { name: 'Database Servers' },
        { name: 'Development Utilities' },
        { name: 'Cloud Platforms' }
      ])
    end
  end
end
