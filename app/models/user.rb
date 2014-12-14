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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
                        case_sensitive: false,
                        exclusion: { in: %w(mail auth),
                                     message: "%{value} is reserved." }

  nilify_blanks :only => [:domain]

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url
		hash = Digest::MD5.hexdigest(email)

		"https://www.gravatar.com/avatar/#{hash}?s=256"
  end
end
