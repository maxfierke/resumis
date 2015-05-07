class CreateUserDefaultsJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    ActsAsTenant.with_tenant(user) do
      ProjectStatus.create([
        { slug: 'active', name: 'Active' },
        { slug: 'inactive', name: 'Inactive' },
        { slug: 'canceled', name: 'Canceled' },
        { slug: 'on-hold', name: 'On Hold' }
      ])
    end
  end
end
