module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :id, :first_name, :last_name, :about_me, :tagline, :full_name,
                 :copyright_range, :avatar_url, :avatar_label, :header_image_url

      attribute :about_me_html do
        markdown(object.about_me)
      end

      link(:self) { api_user_path(object.id) }
      link(:github) {
        {
          meta: {
            rel: 'github',
            title: "@#{object.github_handle}"
          },
          href: "https://github.com/#{object.github_handle}"
        }
      }
      link(:linkedin) {
        {
          meta: {
            rel: 'linkedin',
            title: object.linkedin_handle
          },
          href: "https://linkedin.com/in/#{object.linkedin_handle}"
        }
      }
      link(:mastodon) {
        {
          meta: {
            rel: 'mastodon',
            title: object.mastodon_handle
          },
          href: object.mastodon_url
        }
      }
      link(:medium) {
        {
          meta: {
            rel: 'medium',
            title: "@#{object.medium_handle}"
          },
          href: "https://medium.com/@#{object.medium_handle}"
        }
      }
      link(:twitter) {
        {
          meta: {
            rel: 'twitter',
            title: "@#{object.twitter_handle}",
          },
          href: "https://twitter.com/#{object.twitter_handle}"
        }
      }

      has_many :projects
      has_many :skills
     end
  end
end
