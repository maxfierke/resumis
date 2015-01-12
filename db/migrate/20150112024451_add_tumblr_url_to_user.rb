class AddTumblrURLToUser < ActiveRecord::Migration
  def change
    add_column :users, :tumblr_url, :string
  end
end
