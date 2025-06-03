module SocialLinkHelper
  NETWORK_ICONS = {
    'github' => 'github-square',
    'tumblr' => 'tumblr-square',
    'twitter' => 'twitter-square',
  }.freeze

  def social_link_icon(social_link)
    icon_name = NETWORK_ICONS[social_link.network] || social_link.network
    icon('fab', "#{icon_name} fa-fw h-5 w-5 inline-block mr-4 social-link-icon-#{social_link.network}", social_link.network_name)
  end
end
