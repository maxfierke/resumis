require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
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
  has_many :user_types, dependent: :destroy
  has_many :types, through: :user_types

  accepts_nested_attributes_for :user_types, :allow_destroy => true
  accepts_nested_attributes_for :types

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subdomain, presence: :multi_tenancy?,
                        uniqueness: true,
                        case_sensitive: false,
                        exclusion: { in: Rails.application.config.x.resumis.excluded_subdomains,
                                     message: "%{value} is reserved." }

  enum header_media_type: %w(image video)

  nilify_blanks :only => [:domain]

  mount_uploader :header_image, HeaderImageUploader
  mount_uploader :header_video, HeaderVideoUploader
  mount_uploader :avatar_image, AvatarImageUploader
  process_in_background :avatar_image
  process_in_background :header_video

  def developer?
    types.exists?(slug: 'developer')
  end

  def filmmaker?
    types.exists?(slug: 'filmmaker')
  end

  def musician?
    types.exists?(slug: 'musician')
  end

  def writer?
    types.exists?(slug: 'writer')
  end

  def using_video_header?
    header_media_type == 'video'
  end

  def using_image_header?
    header_media_type == 'image'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url
		hash = Digest::MD5.hexdigest(email)

		"https://www.gravatar.com/avatar/#{hash}?s=256"
  end

  def avatar_url
    avatar_image_url || gravatar_url
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
    networks << { network: 'soundcloud', username: soundcloud_handle, url: "https://soundcloud.com/#{soundcloud_handle}" } if soundcloud_handle.present?
    networks << { network: 'tumblr', username: nil, url: tumblr_url } if tumblr_url.present?
    networks << { network: 'twitter', username: twitter_handle, url: "https://twitter.com/#{twitter_handle}" } if twitter_handle.present?
    networks << { network: 'vimeo', username: vimeo_handle, url: "http://vimeo.com/#{vimeo_handle}" } if vimeo_handle.present?
    networks << { network: 'youtube', username: youtube_handle, url: "https://youtube.com/user/#{youtube_handle}"} if youtube_handle.present?

    networks
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def multi_tenancy?
    Rails.application.config.x.resumis.tenancy_mode == :multi
  end
end
