class Type < ActiveRecord::Base
  has_many :users, through: :user_types

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
