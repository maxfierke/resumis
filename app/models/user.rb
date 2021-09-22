class User < ActiveRecord::Base
  AVATAR_IMAGE_VARIANTS = {
    small: { resize_to_fill: [100, 100] },
    medium: { resize_to_fill: [256, 256] },
    large: { resize_to_fill: [512, 512] },
  }.freeze

  HEADER_IMAGE_VARIANTS = {
    small: { resize_to_fill: [800, 267], gravity: 'center' },
    medium: { resize_to_fill: [1500, 500], gravity: 'center' },
    large: { resize_to_fill: [3000, 1000], gravity: 'center' },
  }.freeze

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
  validates :subdomain, presence: { if: -> { ResumisConfig.multi_tenant? } },
                        uniqueness: { case_sensitive: false },
                        exclusion: { in: ResumisConfig.excluded_subdomains,
                                     message: "%{value} is reserved." }

  nilify_blanks :only => [:domain]

  has_one_attached :avatar_image
  has_one_attached :header_image

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url(size = 256)
    hash = Digest::MD5.hexdigest(email)

    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def avatar_url(size = :medium)
    url = if avatar_image.attached?
      begin
        avatar_image.variant(**AVATAR_IMAGE_VARIANTS[size]).url
      rescue URI::InvalidURIError
        nil
      end
    end

    url || gravatar_url(AVATAR_IMAGE_VARIANTS.dig(size, :resize_to_fill)&.first)
  end

  def header_image_url(size = :medium)
    if header_image.attached?
      begin
        header_image.variant(**HEADER_IMAGE_VARIANTS[size]).url
      rescue URI::InvalidURIError
        nil
      end
    end
  end

  def copyright_range
    current_year = DateTime.now.year

    if created_at.year != current_year
      "#{created_at.year}-#{current_year} #{full_name}"
    else
      "#{current_year} #{full_name}"
    end
  end

  def social_networks
    networks = []

    networks << { network: 'github', username: github_handle, url: "https://github.com/#{github_handle}" } if github_handle.present?
    networks << { network: 'googleplus', username: googleplus_handle, url: "https://plus.google.com/#{googleplus_handle}"} if googleplus_handle.present?
    networks << { network: 'linkedin', username: linkedin_handle, url: "http://www.linkedin.com/in/#{linkedin_handle}/" } if linkedin_handle.present?
    networks << { network: 'tumblr', username: nil, url: tumblr_url } if tumblr_url.present?
    networks << { network: 'twitter', username: twitter_handle, url: "https://twitter.com/#{twitter_handle}" } if twitter_handle.present?
    networks << { network: 'medium', username: medium_handle, url: "https://medium.com/@#{medium_handle}"} if medium_handle.present?

    networks
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
