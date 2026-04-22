class Webhook < ActiveRecord::Base
  RESOURCE_TYPES = %w[post project resume skill].freeze

  belongs_to :user

  encrypts :secret

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :url, presence: true, uniqueness: { scope: :user }
  validates :resource_types,
    presence: true,
    inclusion: { in: RESOURCE_TYPES }
  validate :url_scheme_allowed

  before_create :generate_secret!

  scope :enabled, -> { where(enabled: true) }

  private

  def generate_secret!
    self.secret ||= SecureRandom.hex(32)
  end

  def url_scheme_allowed
    return unless url.present?

    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError
      errors.add(:url, "is not a valid URL")
      return
    end

    allowed_schemes = Rails.env.production? ? %w[https] : %w[http https]
    errors.add(:url, "must use HTTPS") unless allowed_schemes.include?(uri.scheme)
  end
end
