class AddVimeoAndYouTubeHandlesToUser < ActiveRecord::Migration
  def change
    add_column :users, :vimeo_handle, :string
    add_column :users, :youtube_handle, :string
  end
end
