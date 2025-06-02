class User < ActiveRecord::Base
  self.ignored_columns = [
    "ga_view_id",
    "ga_property_id",
    "github_handle",
    "linkedin_handle",
    "mastodon_handle",
    "medium_handle",
    "tumblr_url",
    "twitter_handle",
  ].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, dependent: :destroy
  has_many :project_categories, dependent: :destroy
  has_many :project_statuses, dependent: :destroy
  has_many :resumes, dependent: :destroy
  has_many :work_experiences, dependent: :destroy
  has_many :education_experiences, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :skill_categories, dependent: :destroy
  has_many :social_links, dependent: :destroy
  accepts_nested_attributes_for :social_links, reject_if: :all_blank, allow_destroy: true

  has_many :oauth_access_grants,
    class_name: 'Doorkeeper::AccessGrant',
    foreign_key: :resource_owner_id,
    dependent: :destroy
  has_many :oauth_access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :destroy
  has_many :oauth_applications,
    class_name: 'Doorkeeper::Application',
    as: :owner,
    dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subdomain,
    presence: { if: -> { ResumisConfig.multi_tenant? } },
    uniqueness: { case_sensitive: false },
    exclusion: {
      in: ResumisConfig.excluded_subdomains,
      message: "%{value} is reserved."
  }

  nilify_blanks :only => [:domain]

  has_one_attached :avatar_image do |attachable|
    ImageVariants.variants_for_style(:square).each do |name, opts|
      attachable.variant name, opts
    end
  end

  has_one_attached :header_image do |attachable|
    ImageVariants.variants_for_style(:header).each do |name, opts|
      attachable.variant name, opts
    end
  end

  scope :enabled, -> { where(disabled_at: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url(size = 256)
    hash = Digest::MD5.hexdigest(email)

    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def avatar_url(size: :medium, quality: nil)
    if avatar_image.attached? && avatar_image.image?
      variant = ImageVariants.variant_for_image(avatar_image, size: size, quality: quality)

      if variant.image
        return Rails.application.routes.url_helpers.cdn_blob_url(variant)
      else
        # If variants change, the `image` is nil, and we should fallback &
        # queue processing
        ProfileImageVariantGeneratorJob.perform_later(self.id)
      end
    end

    dimensions = ImageVariants.dimensions_for_style(:square, size)
    gravatar_url(dimensions&.first)
  end

  def header_image_url(size: :medium, quality: nil)
    return unless header_image.attached? && header_image.image?

    variant = ImageVariants.variant_for_image(header_image, size: size, quality: quality)

    if variant.image
      Rails.application.routes.url_helpers.cdn_blob_url(variant)
    else
      # If variants change, the `image` is nil, and we should fallback to nil &
      # queue processing
      ProfileImageVariantGeneratorJob.perform_later(self.id)
      nil
    end
  end

  def copyright_range
    current_year = Time.current.year

    if created_at.year != current_year
      "#{created_at.year}-#{current_year} #{full_name}"
    else
      "#{current_year} #{full_name}"
    end
  end

  def social_networks
    social_links.map do |link|
      {
        network: link.network,
        username: link.username,
        url: link.url
      }
    end
  end

  def disabled?
    !!disabled_at
  end

  def access_locked?
    disabled? || super
  end

  def inactive_message
    if disabled?
      :disabled
    else
      super
    end
  end

  def valid_for_authentication?
    !disabled_at && super
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
