class AddSoundCloudHandleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :soundcloud_handle, :string
  end
end
