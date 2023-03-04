class AddPublicUrlsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :homepage_url, :string
    add_column :users, :blog_url, :string
  end
end
