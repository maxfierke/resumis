class Post < ActiveRecord::Base
  include Webhookable

  # nice slugs from post title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  paginates_per 10

  belongs_to :user

  has_many :post_category_joinings
  has_many :post_categories, through: :post_category_joinings, dependent: :destroy

  validates :title,
    presence: true,
    length: { minimum: 3, maximum: 60 },
    uniqueness: { scope: :user }

  def trigger_webhook?
    published?
  end

  def webhook_triggered?
    attribute_before_last_save(:published) == true
  end
end
