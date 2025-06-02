class SocialLink < ActiveRecord::Base
  KNOWN_NETWORKS = %w[
    bluesky
    facebook
    github
    instagram
    linkedin
    mastodon
    medium
    tiktok
    tumblr
    twitter
  ].freeze
  MASTO_REGEX = /\A@\w+(?:\.\w+)?@\w+(?:\.\w+)?\z/.freeze

  belongs_to :user

  validates :network, inclusion: { in: KNOWN_NETWORKS }, presence: true

  validate :validate_mastodon_format, if: proc { |l| l.network == "mastodon" }
  validate :validate_one_of_username_or_url

  def uses_at_prefix?
    %w[bluesky github instagram medium tiktok twitter].include?(network)
  end

  def display_name
    if uses_at_prefix?
      "@#{username}"
    else
      username
    end
  end

  def network_name
    case network
    when "github"
      "GitHub"
    when "tiktok"
      "TikTok"
    else
      network&.titleize
    end
  end

  def derived_url
    case network
    when "bluesky"
      "https://bsky.app/profile/#{username}"
    when "github"
      "https://github.com/#{username}"
    when "instagram"
      "https://instagram.com/#{username}/"
    when "linkedin"
      "https://linkedin.com/in/#{username}/"
    when "mastodon"
      mastodon_url
    when "medium"
      "https://medium.com/@#{username}"
    when "tiktok"
      "https://tiktok.com/@#{username}"
    when "twitter"
      "https://twitter.com/#{username}"
    end
  end

  private

  def mastodon_url
    return unless username.present? && network == "mastodon"
    handle, host = username.split("@")[1,2]
    "https://#{host}/@#{handle}"
  end

  def validate_mastodon_format
    if username !~ MASTO_REGEX
      errors.add(:username, "must match @user@masto.host format")
    end
  end

  def validate_one_of_username_or_url
    if username.blank? && url.blank?
      errors.add(:base, "must provide either username or url")
    end
  end
end
