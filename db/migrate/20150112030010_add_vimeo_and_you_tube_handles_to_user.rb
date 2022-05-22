class AddVimeoAndYouTubeHandlesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vimeo_handle, :string
    add_column :users, :youtube_handle, :string
  end
end
