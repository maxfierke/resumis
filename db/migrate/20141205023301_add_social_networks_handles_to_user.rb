class AddSocialNetworksHandlesToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_handle, :string
    add_column :users, :googleplus_handle, :string
    add_column :users, :linkedin_handle, :string
    add_column :users, :twitter_handle, :string
  end
end
