class AddHeaderVideoProcessingToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_video_processing, :boolean, null: false, default: false
  end
end
