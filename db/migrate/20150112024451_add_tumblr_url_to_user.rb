class AddTumblrUrlToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tumblr_url, :string
  end
end
