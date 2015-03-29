class Post < ActiveRecord::Base
  # nice slugs from post title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  # we belong to user and are treated as an object of a tenant
  belongs_to :user
  acts_as_tenant(:user)

  has_many :post_category_joinings
  has_many :post_categories, through: :post_category_joinings

  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 3, maximum: 60 }
end
