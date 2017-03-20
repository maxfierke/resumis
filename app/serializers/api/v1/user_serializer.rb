module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :id, :first_name, :last_name, :about_me, :tagline, :avatar_url,
                 :full_name, :copyright_range

      attribute :about_me_html do
        markdown(object.about_me)
      end

      link(:self) { api_v1_user_path(object.id) }
      link(:github) { "https://github.com/#{object.github_handle}" }
      link(:linkedin) { "https://linkedin.com/in/#{object.linkedin_handle}" }
      link(:medium) { "https://medium.com/@#{object.medium_handle}" }
      link(:tumblr) { object.tumblr_url }
      link(:twitter) { "https://twitter.com/#{object.twitter_handle}" }

      has_many :projects
     end
  end
end
