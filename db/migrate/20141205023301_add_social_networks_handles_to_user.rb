class AddSocialNetworksHandlesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github_handle, :string
    add_column :users, :googleplus_handle, :string
    add_column :users, :linkedin_handle, :string
    add_column :users, :twitter_handle, :string
  end
end
