class PostCategory < ActiveRecord::Base
  has_many :post_category_joinings
  has_many :posts, through: :post_category_joinings

  default_scope { order(name: :asc) }

  # nice slugs from category name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates :name, presence: true, uniqueness: true
end
