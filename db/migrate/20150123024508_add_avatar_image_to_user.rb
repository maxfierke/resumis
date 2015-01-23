class AddAvatarImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_image, :string
  end
end
