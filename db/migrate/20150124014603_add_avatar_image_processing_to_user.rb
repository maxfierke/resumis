class AddAvatarImageProcessingToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_image_processing, :boolean, null: false, default: false
  end
end
