class AddHeaderVideoProcessingToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :header_video_processing, :boolean, null: false, default: false
  end
end
