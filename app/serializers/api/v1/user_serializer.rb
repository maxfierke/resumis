module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      include ApplicationHelper

      cache key: 'user',
            expires_in: 12.hours,
            except: [
              :avatar_url,
              :avatar_images,
              :header_image_url,
              :header_images,
            ]

      attributes :id, :first_name, :last_name, :about_me, :tagline, :full_name,
                 :copyright_range, :avatar_url, :avatar_label, :header_image_url

      attribute :about_me_html do
        markdown(object.about_me)
      end

      attribute :avatar_images do
        {
          small: object.avatar_url(size: :small),
          medium: object.avatar_url(size: :medium),
          large: object.avatar_url(size: :large),
        }
      end

      attribute :header_images do
        {
          small: object.header_image_url(size: :small),
          medium: object.header_image_url(size: :medium),
          large: object.header_image_url(size: :large),
        }
      end

      link(:self) { api_user_path(object.id) }

      SocialLink::KNOWN_NETWORKS.each do |network_name|
        link(network_name.to_sym) {
          if social_link = object.social_links.find { |link| link.network == network_name }
            {
              meta: {
                rel: social_link.network,
                title: social_link.display_name
              },
              href: social_link.derived_url
            }
          end
        }
      end

      has_many :projects
      has_many :skills
    end
  end
end
