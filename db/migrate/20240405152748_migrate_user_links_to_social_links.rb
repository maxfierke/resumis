class MigrateUserLinksToSocialLinks < ActiveRecord::Migration[7.1]
  class SocialLink < ActiveRecord::Base
    self.table_name = 'social_links'
    belongs_to :user, class_name: 'MigrateUserLinksToSocialLinks::User'
  end

  class User < ActiveRecord::Base
    self.table_name = 'users'
    has_many :social_links, class_name: 'MigrateUserLinksToSocialLinks::SocialLink'
  end

  def change
    User.find_each do |user|
      if user.github_handle.present?
        user.social_links.create_or_find_by!(network: 'github', username: user.github_handle)
      end

      if user.linkedin_handle.present?
        user.social_links.create_or_find_by!(network: 'linkedin', username: user.linkedin_handle)
      end

      if user.medium_handle.present?
        user.social_links.create_or_find_by!(network: 'medium', username: user.medium_handle)
      end

      if user.mastodon_handle.present?
        user.social_links.create_or_find_by!(network: 'mastodon', username: user.mastodon_handle)
      end

      if user.tumblr_url.present?
        user.social_links.create_or_find_by!(network: 'tumblr', url: user.tumblr_url)
      end

      if user.twitter_handle.present?
        user.social_links.create_or_find_by!(network: 'twitter', username: user.twitter_handle)
      end
    end
  end
end
