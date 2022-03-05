class AddAvatarImageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_image, :string
  end
end
