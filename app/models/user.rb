require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :resumes
  has_many :work_experiences
  has_many :education_experiences
  has_many :skills
  has_many :user_types
  has_many :types, through: :user_types

  accepts_nested_attributes_for :user_types, :allow_destroy => true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
                        case_sensitive: false,
                        exclusion: { in: %w(mail auth api service users ftp ldap),
                                     message: "%{value} is reserved." }

  nilify_blanks :only => [:domain]

  def developer?
    types.exists?(slug: 'developer')
  end

  def filmmaker?
    types.exist?(slug: 'filmmaker')
  end

  def musician?
    types.exist?(slug: 'musician')
  end

  def writer?
    types.exists?(slug: 'writer')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url
		hash = Digest::MD5.hexdigest(email)

		"https://www.gravatar.com/avatar/#{hash}?s=256"
  end

  def copyright_range
    current_year = DateTime.now.year

    if created_at.year != current_year
      "#{created_at.year}-#{current_year} #{full_name}"
    else
      "#{current_year} #{full_name}"
    end
  end
end
