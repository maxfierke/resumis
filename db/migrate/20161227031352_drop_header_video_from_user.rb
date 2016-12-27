class DropHeaderVideoFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :header_media_type
    remove_column :users, :header_video, :string
    remove_column :users, :header_video_processing
  end
end
