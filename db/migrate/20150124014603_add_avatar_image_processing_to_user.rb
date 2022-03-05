class AddAvatarImageProcessingToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_image_processing, :boolean, null: false, default: false
  end
end
