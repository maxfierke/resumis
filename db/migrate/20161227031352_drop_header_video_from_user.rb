class DropHeaderVideoFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :header_media_type
    remove_column :users, :header_video, :string
    remove_column :users, :header_video_processing
  end
end
